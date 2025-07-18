//
// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the protocol buffer compiler.
// Source: com/octopuscommunity/NotificationServiceProto.proto
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `Com_Octopuscommunity_NotificationServiceClient`, then call methods of this protocol to make API calls.
public protocol Com_Octopuscommunity_NotificationServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Com_Octopuscommunity_NotificationServiceClientInterceptorFactoryProtocol? { get }

  func getUserNotifications(
    _ request: Com_Octopuscommunity_GetUserNotificationsRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Com_Octopuscommunity_GetUserNotificationsRequest, Com_Octopuscommunity_GetUserNotificationsResponse>

  func markNotificationsAsRead(
    _ request: Com_Octopuscommunity_MarkNotificationsAsReadRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Com_Octopuscommunity_MarkNotificationsAsReadRequest, Com_Octopuscommunity_MarkNotificationsAsReadResponse>

  func registerPushToken(
    _ request: Com_Octopuscommunity_RegisterPushTokenRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Com_Octopuscommunity_RegisterPushTokenRequest, Com_Octopuscommunity_RegisterPushTokenResponse>

  func setNotificationSettings(
    _ request: Com_Octopuscommunity_SetNotificationSettingsRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Com_Octopuscommunity_SetNotificationSettingsRequest, Com_Octopuscommunity_NotificationSettingsResponse>

  func getNotificationSettings(
    _ request: Com_Octopuscommunity_GetNotificationSettingsRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Com_Octopuscommunity_GetNotificationSettingsRequest, Com_Octopuscommunity_NotificationSettingsResponse>
}

extension Com_Octopuscommunity_NotificationServiceClientProtocol {
  public var serviceName: String {
    return "com.octopuscommunity.NotificationService"
  }

  /// Unary call to GetUserNotifications
  ///
  /// - Parameters:
  ///   - request: Request to send to GetUserNotifications.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func getUserNotifications(
    _ request: Com_Octopuscommunity_GetUserNotificationsRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Com_Octopuscommunity_GetUserNotificationsRequest, Com_Octopuscommunity_GetUserNotificationsResponse> {
    return self.makeUnaryCall(
      path: Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.getUserNotifications.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetUserNotificationsInterceptors() ?? []
    )
  }

  /// Unary call to MarkNotificationsAsRead
  ///
  /// - Parameters:
  ///   - request: Request to send to MarkNotificationsAsRead.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func markNotificationsAsRead(
    _ request: Com_Octopuscommunity_MarkNotificationsAsReadRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Com_Octopuscommunity_MarkNotificationsAsReadRequest, Com_Octopuscommunity_MarkNotificationsAsReadResponse> {
    return self.makeUnaryCall(
      path: Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.markNotificationsAsRead.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMarkNotificationsAsReadInterceptors() ?? []
    )
  }

  /// Unary call to RegisterPushToken
  ///
  /// - Parameters:
  ///   - request: Request to send to RegisterPushToken.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func registerPushToken(
    _ request: Com_Octopuscommunity_RegisterPushTokenRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Com_Octopuscommunity_RegisterPushTokenRequest, Com_Octopuscommunity_RegisterPushTokenResponse> {
    return self.makeUnaryCall(
      path: Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.registerPushToken.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRegisterPushTokenInterceptors() ?? []
    )
  }

  /// Unary call to SetNotificationSettings
  ///
  /// - Parameters:
  ///   - request: Request to send to SetNotificationSettings.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func setNotificationSettings(
    _ request: Com_Octopuscommunity_SetNotificationSettingsRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Com_Octopuscommunity_SetNotificationSettingsRequest, Com_Octopuscommunity_NotificationSettingsResponse> {
    return self.makeUnaryCall(
      path: Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.setNotificationSettings.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSetNotificationSettingsInterceptors() ?? []
    )
  }

  /// Unary call to GetNotificationSettings
  ///
  /// - Parameters:
  ///   - request: Request to send to GetNotificationSettings.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func getNotificationSettings(
    _ request: Com_Octopuscommunity_GetNotificationSettingsRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Com_Octopuscommunity_GetNotificationSettingsRequest, Com_Octopuscommunity_NotificationSettingsResponse> {
    return self.makeUnaryCall(
      path: Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.getNotificationSettings.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetNotificationSettingsInterceptors() ?? []
    )
  }
}

@available(*, deprecated)
extension Com_Octopuscommunity_NotificationServiceClient: @unchecked Sendable {}

@available(*, deprecated, renamed: "Com_Octopuscommunity_NotificationServiceNIOClient")
public final class Com_Octopuscommunity_NotificationServiceClient: Com_Octopuscommunity_NotificationServiceClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: Com_Octopuscommunity_NotificationServiceClientInterceptorFactoryProtocol?
  public let channel: GRPCChannel
  public var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  public var interceptors: Com_Octopuscommunity_NotificationServiceClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the com.octopuscommunity.NotificationService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Com_Octopuscommunity_NotificationServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

public struct Com_Octopuscommunity_NotificationServiceNIOClient: Com_Octopuscommunity_NotificationServiceClientProtocol {
  public var channel: GRPCChannel
  public var defaultCallOptions: CallOptions
  public var interceptors: Com_Octopuscommunity_NotificationServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the com.octopuscommunity.NotificationService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Com_Octopuscommunity_NotificationServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public protocol Com_Octopuscommunity_NotificationServiceAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Com_Octopuscommunity_NotificationServiceClientInterceptorFactoryProtocol? { get }

  func makeGetUserNotificationsCall(
    _ request: Com_Octopuscommunity_GetUserNotificationsRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Com_Octopuscommunity_GetUserNotificationsRequest, Com_Octopuscommunity_GetUserNotificationsResponse>

  func makeMarkNotificationsAsReadCall(
    _ request: Com_Octopuscommunity_MarkNotificationsAsReadRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Com_Octopuscommunity_MarkNotificationsAsReadRequest, Com_Octopuscommunity_MarkNotificationsAsReadResponse>

  func makeRegisterPushTokenCall(
    _ request: Com_Octopuscommunity_RegisterPushTokenRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Com_Octopuscommunity_RegisterPushTokenRequest, Com_Octopuscommunity_RegisterPushTokenResponse>

  func makeSetNotificationSettingsCall(
    _ request: Com_Octopuscommunity_SetNotificationSettingsRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Com_Octopuscommunity_SetNotificationSettingsRequest, Com_Octopuscommunity_NotificationSettingsResponse>

  func makeGetNotificationSettingsCall(
    _ request: Com_Octopuscommunity_GetNotificationSettingsRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Com_Octopuscommunity_GetNotificationSettingsRequest, Com_Octopuscommunity_NotificationSettingsResponse>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Com_Octopuscommunity_NotificationServiceAsyncClientProtocol {
  public static var serviceDescriptor: GRPCServiceDescriptor {
    return Com_Octopuscommunity_NotificationServiceClientMetadata.serviceDescriptor
  }

  public var interceptors: Com_Octopuscommunity_NotificationServiceClientInterceptorFactoryProtocol? {
    return nil
  }

  public func makeGetUserNotificationsCall(
    _ request: Com_Octopuscommunity_GetUserNotificationsRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Com_Octopuscommunity_GetUserNotificationsRequest, Com_Octopuscommunity_GetUserNotificationsResponse> {
    return self.makeAsyncUnaryCall(
      path: Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.getUserNotifications.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetUserNotificationsInterceptors() ?? []
    )
  }

  public func makeMarkNotificationsAsReadCall(
    _ request: Com_Octopuscommunity_MarkNotificationsAsReadRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Com_Octopuscommunity_MarkNotificationsAsReadRequest, Com_Octopuscommunity_MarkNotificationsAsReadResponse> {
    return self.makeAsyncUnaryCall(
      path: Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.markNotificationsAsRead.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMarkNotificationsAsReadInterceptors() ?? []
    )
  }

  public func makeRegisterPushTokenCall(
    _ request: Com_Octopuscommunity_RegisterPushTokenRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Com_Octopuscommunity_RegisterPushTokenRequest, Com_Octopuscommunity_RegisterPushTokenResponse> {
    return self.makeAsyncUnaryCall(
      path: Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.registerPushToken.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRegisterPushTokenInterceptors() ?? []
    )
  }

  public func makeSetNotificationSettingsCall(
    _ request: Com_Octopuscommunity_SetNotificationSettingsRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Com_Octopuscommunity_SetNotificationSettingsRequest, Com_Octopuscommunity_NotificationSettingsResponse> {
    return self.makeAsyncUnaryCall(
      path: Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.setNotificationSettings.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSetNotificationSettingsInterceptors() ?? []
    )
  }

  public func makeGetNotificationSettingsCall(
    _ request: Com_Octopuscommunity_GetNotificationSettingsRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Com_Octopuscommunity_GetNotificationSettingsRequest, Com_Octopuscommunity_NotificationSettingsResponse> {
    return self.makeAsyncUnaryCall(
      path: Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.getNotificationSettings.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetNotificationSettingsInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Com_Octopuscommunity_NotificationServiceAsyncClientProtocol {
  public func getUserNotifications(
    _ request: Com_Octopuscommunity_GetUserNotificationsRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Com_Octopuscommunity_GetUserNotificationsResponse {
    return try await self.performAsyncUnaryCall(
      path: Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.getUserNotifications.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetUserNotificationsInterceptors() ?? []
    )
  }

  public func markNotificationsAsRead(
    _ request: Com_Octopuscommunity_MarkNotificationsAsReadRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Com_Octopuscommunity_MarkNotificationsAsReadResponse {
    return try await self.performAsyncUnaryCall(
      path: Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.markNotificationsAsRead.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMarkNotificationsAsReadInterceptors() ?? []
    )
  }

  public func registerPushToken(
    _ request: Com_Octopuscommunity_RegisterPushTokenRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Com_Octopuscommunity_RegisterPushTokenResponse {
    return try await self.performAsyncUnaryCall(
      path: Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.registerPushToken.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRegisterPushTokenInterceptors() ?? []
    )
  }

  public func setNotificationSettings(
    _ request: Com_Octopuscommunity_SetNotificationSettingsRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Com_Octopuscommunity_NotificationSettingsResponse {
    return try await self.performAsyncUnaryCall(
      path: Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.setNotificationSettings.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSetNotificationSettingsInterceptors() ?? []
    )
  }

  public func getNotificationSettings(
    _ request: Com_Octopuscommunity_GetNotificationSettingsRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Com_Octopuscommunity_NotificationSettingsResponse {
    return try await self.performAsyncUnaryCall(
      path: Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.getNotificationSettings.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetNotificationSettingsInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public struct Com_Octopuscommunity_NotificationServiceAsyncClient: Com_Octopuscommunity_NotificationServiceAsyncClientProtocol {
  public var channel: GRPCChannel
  public var defaultCallOptions: CallOptions
  public var interceptors: Com_Octopuscommunity_NotificationServiceClientInterceptorFactoryProtocol?

  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Com_Octopuscommunity_NotificationServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

public protocol Com_Octopuscommunity_NotificationServiceClientInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when invoking 'getUserNotifications'.
  func makeGetUserNotificationsInterceptors() -> [ClientInterceptor<Com_Octopuscommunity_GetUserNotificationsRequest, Com_Octopuscommunity_GetUserNotificationsResponse>]

  /// - Returns: Interceptors to use when invoking 'markNotificationsAsRead'.
  func makeMarkNotificationsAsReadInterceptors() -> [ClientInterceptor<Com_Octopuscommunity_MarkNotificationsAsReadRequest, Com_Octopuscommunity_MarkNotificationsAsReadResponse>]

  /// - Returns: Interceptors to use when invoking 'registerPushToken'.
  func makeRegisterPushTokenInterceptors() -> [ClientInterceptor<Com_Octopuscommunity_RegisterPushTokenRequest, Com_Octopuscommunity_RegisterPushTokenResponse>]

  /// - Returns: Interceptors to use when invoking 'setNotificationSettings'.
  func makeSetNotificationSettingsInterceptors() -> [ClientInterceptor<Com_Octopuscommunity_SetNotificationSettingsRequest, Com_Octopuscommunity_NotificationSettingsResponse>]

  /// - Returns: Interceptors to use when invoking 'getNotificationSettings'.
  func makeGetNotificationSettingsInterceptors() -> [ClientInterceptor<Com_Octopuscommunity_GetNotificationSettingsRequest, Com_Octopuscommunity_NotificationSettingsResponse>]
}

public enum Com_Octopuscommunity_NotificationServiceClientMetadata {
  public static let serviceDescriptor = GRPCServiceDescriptor(
    name: "NotificationService",
    fullName: "com.octopuscommunity.NotificationService",
    methods: [
      Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.getUserNotifications,
      Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.markNotificationsAsRead,
      Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.registerPushToken,
      Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.setNotificationSettings,
      Com_Octopuscommunity_NotificationServiceClientMetadata.Methods.getNotificationSettings,
    ]
  )

  public enum Methods {
    public static let getUserNotifications = GRPCMethodDescriptor(
      name: "GetUserNotifications",
      path: "/com.octopuscommunity.NotificationService/GetUserNotifications",
      type: GRPCCallType.unary
    )

    public static let markNotificationsAsRead = GRPCMethodDescriptor(
      name: "MarkNotificationsAsRead",
      path: "/com.octopuscommunity.NotificationService/MarkNotificationsAsRead",
      type: GRPCCallType.unary
    )

    public static let registerPushToken = GRPCMethodDescriptor(
      name: "RegisterPushToken",
      path: "/com.octopuscommunity.NotificationService/RegisterPushToken",
      type: GRPCCallType.unary
    )

    public static let setNotificationSettings = GRPCMethodDescriptor(
      name: "SetNotificationSettings",
      path: "/com.octopuscommunity.NotificationService/SetNotificationSettings",
      type: GRPCCallType.unary
    )

    public static let getNotificationSettings = GRPCMethodDescriptor(
      name: "GetNotificationSettings",
      path: "/com.octopuscommunity.NotificationService/GetNotificationSettings",
      type: GRPCCallType.unary
    )
  }
}

/// To build a server, implement a class that conforms to this protocol.
public protocol Com_Octopuscommunity_NotificationServiceProvider: CallHandlerProvider {
  var interceptors: Com_Octopuscommunity_NotificationServiceServerInterceptorFactoryProtocol? { get }

  func getUserNotifications(request: Com_Octopuscommunity_GetUserNotificationsRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Com_Octopuscommunity_GetUserNotificationsResponse>

  func markNotificationsAsRead(request: Com_Octopuscommunity_MarkNotificationsAsReadRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Com_Octopuscommunity_MarkNotificationsAsReadResponse>

  func registerPushToken(request: Com_Octopuscommunity_RegisterPushTokenRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Com_Octopuscommunity_RegisterPushTokenResponse>

  func setNotificationSettings(request: Com_Octopuscommunity_SetNotificationSettingsRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Com_Octopuscommunity_NotificationSettingsResponse>

  func getNotificationSettings(request: Com_Octopuscommunity_GetNotificationSettingsRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Com_Octopuscommunity_NotificationSettingsResponse>
}

extension Com_Octopuscommunity_NotificationServiceProvider {
  public var serviceName: Substring {
    return Com_Octopuscommunity_NotificationServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  public func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "GetUserNotifications":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Com_Octopuscommunity_GetUserNotificationsRequest>(),
        responseSerializer: ProtobufSerializer<Com_Octopuscommunity_GetUserNotificationsResponse>(),
        interceptors: self.interceptors?.makeGetUserNotificationsInterceptors() ?? [],
        userFunction: self.getUserNotifications(request:context:)
      )

    case "MarkNotificationsAsRead":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Com_Octopuscommunity_MarkNotificationsAsReadRequest>(),
        responseSerializer: ProtobufSerializer<Com_Octopuscommunity_MarkNotificationsAsReadResponse>(),
        interceptors: self.interceptors?.makeMarkNotificationsAsReadInterceptors() ?? [],
        userFunction: self.markNotificationsAsRead(request:context:)
      )

    case "RegisterPushToken":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Com_Octopuscommunity_RegisterPushTokenRequest>(),
        responseSerializer: ProtobufSerializer<Com_Octopuscommunity_RegisterPushTokenResponse>(),
        interceptors: self.interceptors?.makeRegisterPushTokenInterceptors() ?? [],
        userFunction: self.registerPushToken(request:context:)
      )

    case "SetNotificationSettings":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Com_Octopuscommunity_SetNotificationSettingsRequest>(),
        responseSerializer: ProtobufSerializer<Com_Octopuscommunity_NotificationSettingsResponse>(),
        interceptors: self.interceptors?.makeSetNotificationSettingsInterceptors() ?? [],
        userFunction: self.setNotificationSettings(request:context:)
      )

    case "GetNotificationSettings":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Com_Octopuscommunity_GetNotificationSettingsRequest>(),
        responseSerializer: ProtobufSerializer<Com_Octopuscommunity_NotificationSettingsResponse>(),
        interceptors: self.interceptors?.makeGetNotificationSettingsInterceptors() ?? [],
        userFunction: self.getNotificationSettings(request:context:)
      )

    default:
      return nil
    }
  }
}

/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public protocol Com_Octopuscommunity_NotificationServiceAsyncProvider: CallHandlerProvider, Sendable {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Com_Octopuscommunity_NotificationServiceServerInterceptorFactoryProtocol? { get }

  func getUserNotifications(
    request: Com_Octopuscommunity_GetUserNotificationsRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Com_Octopuscommunity_GetUserNotificationsResponse

  func markNotificationsAsRead(
    request: Com_Octopuscommunity_MarkNotificationsAsReadRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Com_Octopuscommunity_MarkNotificationsAsReadResponse

  func registerPushToken(
    request: Com_Octopuscommunity_RegisterPushTokenRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Com_Octopuscommunity_RegisterPushTokenResponse

  func setNotificationSettings(
    request: Com_Octopuscommunity_SetNotificationSettingsRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Com_Octopuscommunity_NotificationSettingsResponse

  func getNotificationSettings(
    request: Com_Octopuscommunity_GetNotificationSettingsRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Com_Octopuscommunity_NotificationSettingsResponse
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Com_Octopuscommunity_NotificationServiceAsyncProvider {
  public static var serviceDescriptor: GRPCServiceDescriptor {
    return Com_Octopuscommunity_NotificationServiceServerMetadata.serviceDescriptor
  }

  public var serviceName: Substring {
    return Com_Octopuscommunity_NotificationServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  public var interceptors: Com_Octopuscommunity_NotificationServiceServerInterceptorFactoryProtocol? {
    return nil
  }

  public func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "GetUserNotifications":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Com_Octopuscommunity_GetUserNotificationsRequest>(),
        responseSerializer: ProtobufSerializer<Com_Octopuscommunity_GetUserNotificationsResponse>(),
        interceptors: self.interceptors?.makeGetUserNotificationsInterceptors() ?? [],
        wrapping: { try await self.getUserNotifications(request: $0, context: $1) }
      )

    case "MarkNotificationsAsRead":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Com_Octopuscommunity_MarkNotificationsAsReadRequest>(),
        responseSerializer: ProtobufSerializer<Com_Octopuscommunity_MarkNotificationsAsReadResponse>(),
        interceptors: self.interceptors?.makeMarkNotificationsAsReadInterceptors() ?? [],
        wrapping: { try await self.markNotificationsAsRead(request: $0, context: $1) }
      )

    case "RegisterPushToken":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Com_Octopuscommunity_RegisterPushTokenRequest>(),
        responseSerializer: ProtobufSerializer<Com_Octopuscommunity_RegisterPushTokenResponse>(),
        interceptors: self.interceptors?.makeRegisterPushTokenInterceptors() ?? [],
        wrapping: { try await self.registerPushToken(request: $0, context: $1) }
      )

    case "SetNotificationSettings":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Com_Octopuscommunity_SetNotificationSettingsRequest>(),
        responseSerializer: ProtobufSerializer<Com_Octopuscommunity_NotificationSettingsResponse>(),
        interceptors: self.interceptors?.makeSetNotificationSettingsInterceptors() ?? [],
        wrapping: { try await self.setNotificationSettings(request: $0, context: $1) }
      )

    case "GetNotificationSettings":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Com_Octopuscommunity_GetNotificationSettingsRequest>(),
        responseSerializer: ProtobufSerializer<Com_Octopuscommunity_NotificationSettingsResponse>(),
        interceptors: self.interceptors?.makeGetNotificationSettingsInterceptors() ?? [],
        wrapping: { try await self.getNotificationSettings(request: $0, context: $1) }
      )

    default:
      return nil
    }
  }
}

public protocol Com_Octopuscommunity_NotificationServiceServerInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when handling 'getUserNotifications'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetUserNotificationsInterceptors() -> [ServerInterceptor<Com_Octopuscommunity_GetUserNotificationsRequest, Com_Octopuscommunity_GetUserNotificationsResponse>]

  /// - Returns: Interceptors to use when handling 'markNotificationsAsRead'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeMarkNotificationsAsReadInterceptors() -> [ServerInterceptor<Com_Octopuscommunity_MarkNotificationsAsReadRequest, Com_Octopuscommunity_MarkNotificationsAsReadResponse>]

  /// - Returns: Interceptors to use when handling 'registerPushToken'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeRegisterPushTokenInterceptors() -> [ServerInterceptor<Com_Octopuscommunity_RegisterPushTokenRequest, Com_Octopuscommunity_RegisterPushTokenResponse>]

  /// - Returns: Interceptors to use when handling 'setNotificationSettings'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeSetNotificationSettingsInterceptors() -> [ServerInterceptor<Com_Octopuscommunity_SetNotificationSettingsRequest, Com_Octopuscommunity_NotificationSettingsResponse>]

  /// - Returns: Interceptors to use when handling 'getNotificationSettings'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetNotificationSettingsInterceptors() -> [ServerInterceptor<Com_Octopuscommunity_GetNotificationSettingsRequest, Com_Octopuscommunity_NotificationSettingsResponse>]
}

public enum Com_Octopuscommunity_NotificationServiceServerMetadata {
  public static let serviceDescriptor = GRPCServiceDescriptor(
    name: "NotificationService",
    fullName: "com.octopuscommunity.NotificationService",
    methods: [
      Com_Octopuscommunity_NotificationServiceServerMetadata.Methods.getUserNotifications,
      Com_Octopuscommunity_NotificationServiceServerMetadata.Methods.markNotificationsAsRead,
      Com_Octopuscommunity_NotificationServiceServerMetadata.Methods.registerPushToken,
      Com_Octopuscommunity_NotificationServiceServerMetadata.Methods.setNotificationSettings,
      Com_Octopuscommunity_NotificationServiceServerMetadata.Methods.getNotificationSettings,
    ]
  )

  public enum Methods {
    public static let getUserNotifications = GRPCMethodDescriptor(
      name: "GetUserNotifications",
      path: "/com.octopuscommunity.NotificationService/GetUserNotifications",
      type: GRPCCallType.unary
    )

    public static let markNotificationsAsRead = GRPCMethodDescriptor(
      name: "MarkNotificationsAsRead",
      path: "/com.octopuscommunity.NotificationService/MarkNotificationsAsRead",
      type: GRPCCallType.unary
    )

    public static let registerPushToken = GRPCMethodDescriptor(
      name: "RegisterPushToken",
      path: "/com.octopuscommunity.NotificationService/RegisterPushToken",
      type: GRPCCallType.unary
    )

    public static let setNotificationSettings = GRPCMethodDescriptor(
      name: "SetNotificationSettings",
      path: "/com.octopuscommunity.NotificationService/SetNotificationSettings",
      type: GRPCCallType.unary
    )

    public static let getNotificationSettings = GRPCMethodDescriptor(
      name: "GetNotificationSettings",
      path: "/com.octopuscommunity.NotificationService/GetNotificationSettings",
      type: GRPCCallType.unary
    )
  }
}
