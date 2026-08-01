import 'package:core_kit/src/services/logger_service.dart';
import 'package:dio/dio.dart';

/// Dio Interceptor for logging all HTTP requests, responses, and errors.
///
/// This interceptor logs:
/// - Request: Method, URL, Headers, Query Parameters, Body
/// - Response: Status Code, Headers, Body
/// - Error: Error Type, Message, StackTrace
///
/// Note: This class is named ApiLogInterceptor to avoid conflicts
/// with the built-in LogInterceptor from the Dio package.
///
/// Usage:
/// ```dart
/// final dio = Dio();
/// dio.interceptors.add(ApiLogInterceptor());
/// ```
class ApiLogInterceptor extends Interceptor {
  /// Enable/disable logging request body (default: true)
  final bool logRequestBody;

  /// Enable/disable logging response body (default: true)
  final bool logResponseBody;

  /// Enable/disable logging headers (default: true)
  final bool logHeaders;

  /// Maximum body length to log (to prevent excessively large logs).
  final int maxBodyLength;

  ApiLogInterceptor({
    this.logRequestBody = true,
    this.logResponseBody = true,
    this.logHeaders = true,
    this.maxBodyLength = 2000,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LoggerService.logRequest(
      method: options.method,
      url: options.uri.toString(),
      headers: logHeaders
          ? options.headers.map((k, v) => MapEntry(k, v.toString()))
          : null,
      body: logRequestBody && options.data != null
          ? _formatBody(options.data)
          : null,
    );

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    LoggerService.logResponse(
      method: response.requestOptions.method,
      url: response.requestOptions.uri.toString(),
      statusCode: response.statusCode ?? 0,
      headers: logHeaders
          ? response.headers.map.map((k, v) => MapEntry(k, v.join(", ")))
          : null,
      body: logResponseBody && response.data != null
          ? _formatBody(response.data)
          : null,
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    LoggerService.logError(
      method: err.requestOptions.method,
      url: err.requestOptions.uri.toString(),
      error: err,
      stackTrace: err.stackTrace,
    );

    super.onError(err, handler);
  }

  /// Format body for logging with truncation if too long.
  String _formatBody(dynamic body) {
    try {
      String bodyStr;

      if (body is Map || body is List) {
        // Convert to JSON string
        bodyStr = body.toString();
      } else if (body is String) {
        bodyStr = body;
      } else if (body is FormData) {
        bodyStr =
            'FormData: ${body.fields.length} fields, ${body.files.length} files';
        // Log form fields
        if (body.fields.isNotEmpty) {
          bodyStr += '\n   Fields:';
          for (var field in body.fields) {
            bodyStr += '\n      ${field.key}: ${field.value}';
          }
        }
        // Log files info
        if (body.files.isNotEmpty) {
          bodyStr += '\n   Files:';
          for (var file in body.files) {
            bodyStr += '\n      ${file.key}: ${file.value.filename}';
          }
        }
        return bodyStr;
      } else {
        bodyStr = body.toString();
      }

      // Truncate if too long
      if (bodyStr.length > maxBodyLength) {
        return '${bodyStr.substring(0, maxBodyLength)}... (truncated, total: ${bodyStr.length} chars)';
      }

      return bodyStr;
    } catch (e) {
      return 'Failed to format body: $e';
    }
  }
}
