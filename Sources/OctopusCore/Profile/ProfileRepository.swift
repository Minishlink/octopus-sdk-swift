//
//  Copyright © 2024 Octopus Community. All rights reserved.
//

import Foundation
import Combine
import OctopusRemoteClient
import os
import OctopusDependencyInjection
import OctopusGrpcModels

public protocol ProfileRepository: Sendable {
    var profile: CurrentUserProfile? { get }
    var profilePublisher: AnyPublisher<CurrentUserProfile?, Never> { get }

    var hasLoadedProfile: Bool { get }
    var hasLoadedProfilePublisher: AnyPublisher<Bool, Never> { get }

    var onCurrentUserProfileUpdated: AnyPublisher<Void, Never> { get }

    func fetchCurrentUserProfile() async throws(AuthenticatedActionError)

    @discardableResult
    func createCurrentUserProfile(with profile: EditableProfile) async throws(UpdateProfile.Error)
    -> (CurrentUserProfile, Data?)

    @discardableResult
    func updateCurrentUserProfile(with profile: EditableProfile) async throws(UpdateProfile.Error)
    -> (CurrentUserProfile, Data?)

    func deleteCurrentUserProfile(profileId: String) async throws
    func resetNotificationBadgeCount() async throws

    func getProfile(profileId: String) -> AnyPublisher<Profile?, Error>
    func fetchProfile(profileId: String) async throws(ServerCallError)
    func blockUser(profileId: String) async throws(AuthenticatedActionError)
}

extension Injected {
    static let profileRepository = Injector.InjectedIdentifier<ProfileRepository>()
}

class ProfileRepositoryDefault: ProfileRepository, InjectableObject, @unchecked Sendable {
    static let injectedIdentifier = Injected.profileRepository

    @Published public private(set) var profile: CurrentUserProfile?
    var profilePublisher: AnyPublisher<CurrentUserProfile?, Never> { $profile.eraseToAnyPublisher() }
    @Published private(set) var hasLoadedProfile: Bool = false
    var hasLoadedProfilePublisher: AnyPublisher<Bool, Never> { $hasLoadedProfile.eraseToAnyPublisher() }

    public var onCurrentUserProfileUpdated: AnyPublisher<Void, Never> {
        _onCurrentUserProfileUpdated.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    private let _onCurrentUserProfileUpdated = PassthroughSubject<Void, Never>()

    @UserDefault(key: "OctopusSDK.client.user.picture") private var latestClientUserPicture: Data?

    private let appManagedFields: Set<ConnectionMode.SSOConfiguration.ProfileField>
    private let remoteClient: OctopusRemoteClient
    private let userDataStorage: UserDataStorage
    private let authCallProvider: AuthenticatedCallProvider
    private let userProfileDatabase: CurrentUserProfileDatabase
    private let publicProfileDatabase: PublicProfileDatabase
    private let networkMonitor: NetworkMonitor
    private let userProfileFetchMonitor: UserProfileFetchMonitor
    private let validator: Validators.CurrentUserProfile
    private let postFeedsStore: PostFeedsStore
    private let clientUserProvider: ClientUserProvider
    private var storage: Set<AnyCancellable> = []

    init(appManagedFields: Set<ConnectionMode.SSOConfiguration.ProfileField>, injector: Injector) {
        self.appManagedFields = appManagedFields
        remoteClient = injector.getInjected(identifiedBy: Injected.remoteClient)
        userDataStorage = injector.getInjected(identifiedBy: Injected.userDataStorage)
        authCallProvider = injector.getInjected(identifiedBy: Injected.authenticatedCallProvider)
        userProfileDatabase = injector.getInjected(identifiedBy: Injected.currentUserProfileDatabase)
        publicProfileDatabase = injector.getInjected(identifiedBy: Injected.publicProfileDatabase)
        networkMonitor = injector.getInjected(identifiedBy: Injected.networkMonitor)
        userProfileFetchMonitor = injector.getInjected(identifiedBy: Injected.userProfileFetchMonitor)
        validator = injector.getInjected(identifiedBy: Injected.validators).currentUserProfile
        postFeedsStore = injector.getInjected(identifiedBy: Injected.postFeedsStore)
        clientUserProvider = injector.getInjected(identifiedBy: Injected.clientUserProvider)

        userDataStorage.$userData
            .receive(on: DispatchQueue.main)
            .map { [unowned self] userData in
                guard let userData else {
                    return Just<CurrentUserProfile?>(nil).eraseToAnyPublisher()
                }
                return userProfileDatabase.profilePublisher(userId: userData.id)
                    .replaceError(with: nil)
                    .map { [unowned self] in
                        guard let storableProfile = $0 else { return nil }
                        return CurrentUserProfile(storableProfile: storableProfile, postFeedsStore: postFeedsStore)
                    }
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] in
                self.profile = $0
                hasLoadedProfile = true
            }.store(in: &storage)

        userProfileFetchMonitor.userProfileResponsePublisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] response, userId in
                Task {
                    do {
                        try await processCurrentUserProfileResponse(response, userId: userId)
                    } catch {
                        if #available(iOS 14, *) { Logger.profile.debug("Error while processing user profile response: \(error)") }
                    }
                }
            }
            .store(in: &storage)

        Publishers.CombineLatest3(
            $profile.removeDuplicates(),
            clientUserProvider.$clientUser,
            networkMonitor.connectionAvailablePublisher
        )
        .sink { [unowned self] profile, clientUser, connectionAvailable in
            guard connectionAvailable, let profile, let clientUser else { return }
            var hasUpdate = false
            let nickname: EditableProfile.FieldUpdate<String>
            if appManagedFields.contains(.nickname),
               let clientNickname = clientUser.profile.nickname,
               profile.nickname != clientNickname {
                if #available(iOS 14, *) { Logger.profile.trace("Nickname changed (old: \(profile.nickname), new: \(clientNickname))") }
                nickname = .updated(clientNickname)
                hasUpdate = true
            } else {
                nickname = .notUpdated
            }

            let bio: EditableProfile.FieldUpdate<String?>
            if appManagedFields.contains(.bio), profile.bio != clientUser.profile.bio {
                if #available(iOS 14, *) { Logger.profile.trace("Bio changed (old: \(profile.bio ?? "nil"), new: \(clientUser.profile.bio ?? "nil"))") }
                bio = .updated(clientUser.profile.bio)
                hasUpdate = true
            } else {
                bio = .notUpdated
            }

            let picture: EditableProfile.FieldUpdate<Data?>
            if appManagedFields.contains(.picture), latestClientUserPicture != clientUser.profile.picture {
                if #available(iOS 14, *) { Logger.profile.trace("Picture changed") }
                picture = .updated(clientUser.profile.picture)
                hasUpdate = true
            } else {
                picture = .notUpdated
            }

            if hasUpdate {
                Task {
                    let previousClientUserPicture = latestClientUserPicture
                    do {
                        latestClientUserPicture = clientUser.profile.picture
                        try await updateCurrentUserProfile(with: EditableProfile(nickname: nickname, bio: bio,
                                                                                 picture: picture))
                    } catch {
                        // rollback client picture hash
                        latestClientUserPicture = previousClientUserPicture
                        if #available(iOS 14, *) { Logger.profile.debug("Error syncing profile: \(error)") }
                    }
                }
            }
        }.store(in: &storage)
    }

    // MARK: Current User APIs

    public func fetchCurrentUserProfile() async throws(AuthenticatedActionError) {
        guard networkMonitor.connectionAvailable else { throw .noNetwork }
        guard let userData = userDataStorage.userData else {
            throw .userNotAuthenticated
        }
        do {
            let profileResponse = try await remoteClient.userService.getPrivateProfile(
                userId: userData.id, authenticationMethod: try authCallProvider.authenticatedMethod())
            try await processCurrentUserProfileResponse(profileResponse, userId: userData.id)
        } catch {
            if let error = error as? AuthenticatedActionError {
                throw error
            } else if let error = error as? RemoteClientError {
                throw .serverError(ServerError(remoteClientError: error))
            } else {
                throw .other(error)
            }
        }
    }

    @discardableResult
    public func createCurrentUserProfile(with profile: EditableProfile)
    async throws(UpdateProfile.Error) -> (CurrentUserProfile, Data?) {
        try await createOrUpdateUserProfile(with: profile, isCreation: true)
    }

    @discardableResult
    public func updateCurrentUserProfile(with profile: EditableProfile)
    async throws(UpdateProfile.Error) -> (CurrentUserProfile, Data?) {
        try await createOrUpdateUserProfile(with: profile, isCreation: false)
    }

    func deleteCurrentUserProfile(profileId: String) async throws {
        try await userProfileDatabase.delete(profileId: profileId)
    }

    func resetNotificationBadgeCount() async throws {
        guard let profile else { throw InternalError.incorrectState }
        try await userProfileDatabase.resetNotificationBadgeCount(on: profile.id)
    }

    // MARK: Other users APIs

    public func getProfile(profileId: String) -> AnyPublisher<Profile?, Error> {
        publicProfileDatabase.profilePublisher(profileId: profileId)
            .map { [unowned self] in
                guard let storableProfile = $0 else { return nil }
                return Profile(storableProfile: storableProfile, postFeedsStore: postFeedsStore)
            }
            .eraseToAnyPublisher()
    }

    public func fetchProfile(profileId: String) async throws(ServerCallError) {
        guard networkMonitor.connectionAvailable else { throw .noNetwork }
        do {
            let profileResponse = try await remoteClient.userService.getPublicProfile(
                profileId: profileId,
                authenticationMethod: authCallProvider.authenticatedIfPossibleMethod())
            try await publicProfileDatabase.upsert(profile: StorableProfile(from: profileResponse.profile))
        } catch {
            if let error = error as? RemoteClientError {
                throw .serverError(ServerError(remoteClientError: error))
            } else {
                throw .other(error)
            }
        }
    }

    public func blockUser(profileId: String) async throws(AuthenticatedActionError) {
        guard let profile = profile else { throw .userNotAuthenticated }
        guard profileId != profile.id else { throw .other(InternalError.invalidArgument) }
        guard networkMonitor.connectionAvailable else { throw .noNetwork }
        do {
            _ = try await remoteClient.userService.blockUser(
                profileId: profileId,
                authenticationMethod: try authCallProvider.authenticatedMethod())

            var existingBlockedIds = profile.blockedProfileIds
            existingBlockedIds.append(profileId)
            try await userProfileDatabase.update(blockedProfileIds: existingBlockedIds, on: profile.id)
        } catch {
            if let error = error as? AuthenticatedActionError {
                throw error
            } else if let error = error as? RemoteClientError {
                throw .serverError(ServerError(remoteClientError: error))
            } else {
                throw .other(error)
            }
        }
    }

    @discardableResult
    func createOrUpdateUserProfile(with profile: EditableProfile, isCreation: Bool)
    async throws(UpdateProfile.Error) -> (CurrentUserProfile, Data?) {
        guard validator.validate(profile: profile) else {
            throw .serverCall(.other(InternalError.objectMalformed))
        }
        // this function can be called when we are not yet fully connected, so we do not use the user but the userData
        guard let userData = userDataStorage.userData else {
            throw .serverCall(.userNotAuthenticated)
        }
        guard networkMonitor.connectionAvailable else { throw .serverCall(.noNetwork) }
        do {
            var resizedPicture: Data?
            var pictureUpdate: EditableProfile.FieldUpdate<(imgData: Data, isCompressed: Bool)?> = .notUpdated
            if case let .updated(imageData) = profile.picture, let imageData {
                let (resizedImgData, isCompressed) = ImageResizer.resizeIfNeeded(imageData: imageData)
                resizedPicture = resizedImgData
                pictureUpdate = .updated((imgData: resizedImgData, isCompressed: isCompressed))
            }
            let response = try await remoteClient.userService.updateProfile(
                userId: userData.id,
                nickname: profile.nickname.backendValue,
                bio: profile.bio.backendValue,
                picture: pictureUpdate.backendValue,
                isProfileCreation: isCreation,
                authenticationMethod: try authCallProvider.authenticatedMethod())
            switch response.result {
            case let .success(content):
                if let profile = StorableCurrentUserProfile(from: content.profile, userId: userData.id) {
                    try await userProfileDatabase.upsert(profile: profile)
                    _onCurrentUserProfileUpdated.send()
                    let userProfile = CurrentUserProfile(storableProfile: profile, postFeedsStore: postFeedsStore)
                    return (userProfile, resizedPicture)
                } else {
                    throw UpdateProfile.Error.serverCall(.other(nil))
                }

            case let .fail(failure):
                throw UpdateProfile.Error.validation(.init(from: failure))
            case .none:
                throw UpdateProfile.Error.serverCall(.other(nil))
            }
        } catch {
            if #available(iOS 14, *) { Logger.profile.debug("update profile failed with error: \(error)") }
            if let error = error as? UpdateProfile.Error {
                throw error
            } else if let error = error as? AuthenticatedActionError {
                throw .serverCall(error)
            } else if let error = error as? RemoteClientError {
                throw .serverCall(.serverError(ServerError(remoteClientError: error)))
            } else {
                throw .serverCall(.other(error))
            }
        }
    }

    private func processCurrentUserProfileResponse(_ response: Com_Octopuscommunity_GetPrivateProfileResponse,
                                                   userId: String) async throws {
        guard response.hasProfile,
              let profile = StorableCurrentUserProfile(from: response.profile, userId: userId) else {
            throw InternalError.objectMalformed
        }
        try await userProfileDatabase.upsert(profile: profile)
    }
}
