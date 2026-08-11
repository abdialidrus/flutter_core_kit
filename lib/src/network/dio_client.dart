import 'package:core_kit/core_kit.dart';
import 'package:dio/dio.dart';

/// Dio Client for handling HTTP requests.
///
/// Usage:
/// ```dart
/// final client = DioClient(baseURL: 'https://api.example.com/');
/// final response = await client.get('/users');
/// ```
class DioClient {
  late final Dio _dio;
  AuthInterceptor? _authInterceptor;

  /// Default connection timeout in seconds.
  static const int _defaultTimeoutSeconds = 30;

  DioClient({
    required String baseURL,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    List<Interceptor>? interceptors,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        connectTimeout:
            connectTimeout ?? const Duration(seconds: _defaultTimeoutSeconds),
        receiveTimeout:
            receiveTimeout ?? const Duration(seconds: _defaultTimeoutSeconds),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add log interceptor
    _dio.interceptors.add(
      ApiLogInterceptor(
        logRequestBody: true,
        logResponseBody: true,
        logHeaders: true,
        maxBodyLength: 2000,
      ),
    );

    // Add any extra interceptors provided by the consumer
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  /// The underlying [Dio] instance, exposed for advanced use cases
  /// (e.g. adding custom interceptors).
  Dio get dio => _dio;

  /// Add an [AuthInterceptor] that injects a bearer token into every request.
  ///
  /// Call this after login / token refresh:
  /// ```dart
  /// client.addAuthInterceptor(
  ///   tokenProvider: () async => secureStorage.read('access_token'),
  /// );
  /// ```
  void addAuthInterceptor({
    required Future<String?> Function() tokenProvider,
    String headerKey = 'Authorization',
    String Function(String token)? headerValueBuilder,
    OnUnauthorizedCallback? onUnauthorized,
  }) {
    removeAuthInterceptor();
    _authInterceptor = AuthInterceptor(
      tokenProvider: tokenProvider,
      headerKey: headerKey,
      headerValueBuilder: headerValueBuilder ?? (token) => 'Bearer $token',
      onUnauthorized: onUnauthorized,
    );
    _dio.interceptors.add(_authInterceptor!);
  }

  /// Remove auth interceptor (should be called after logout).
  void removeAuthInterceptor() {
    if (_authInterceptor != null) {
      _dio.interceptors.remove(_authInterceptor);
      _authInterceptor = null;
    }
  }

  /// Update base URL at runtime.
  void updateBaseUrl(String newBaseUrl) {
    final url = newBaseUrl.endsWith('/') ? newBaseUrl : '$newBaseUrl/';
    _dio.options.baseUrl = url;
  }

  /// Get current base URL.
  String get baseUrl => _dio.options.baseUrl;

  /// GET request.
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get(path, queryParameters: queryParameters, options: options);
  }

  /// POST request.
  Future<Response<dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// PUT request.
  Future<Response<dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// PATCH request.
  Future<Response<dynamic>> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// DELETE request.
  Future<Response<dynamic>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}

/// Callback type untuk handle 401 Unauthorized
typedef OnUnauthorizedCallback = void Function();

/// Interceptor that injects an auth token into every outgoing request.
///
/// The token is fetched lazily via [tokenProvider] on each request, so it
/// naturally picks up refreshed tokens without the caller needing to
/// re-register the interceptor.
class AuthInterceptor extends Interceptor {
  final Future<String?> Function() tokenProvider;
  final String headerKey;
  final String Function(String token) headerValueBuilder;
  final OnUnauthorizedCallback? onUnauthorized;

  AuthInterceptor({
    required this.tokenProvider,
    this.headerKey = 'Authorization',
    required this.headerValueBuilder,
    this.onUnauthorized,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenProvider();
    if (token != null && token.isNotEmpty) {
      options.headers[headerKey] = headerValueBuilder(token);
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      final shouldSkipAutoLogout =
          err.requestOptions.extra[RequestExtras.skipAutoLogoutOn401] == true;

      if (!shouldSkipAutoLogout) {
        onUnauthorized?.call();
      }
    }

    super.onError(err, handler);
  }
}
