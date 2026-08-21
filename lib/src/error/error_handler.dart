import 'package:core_kit/src/error/failures.dart';
import 'package:dio/dio.dart';

/// Centralized error handler for Dio exceptions
/// Converts DioException to appropriate Failure types
class ErrorHandler {
  /// Handle Dio exceptions and convert to Failure
  static Failure handleDioException(DioException e, {String? fallbackMessage}) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure(
          fallbackMessage ?? 'Connection timeout. Please try again.',
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(e, fallbackMessage: fallbackMessage);

      case DioExceptionType.connectionError:
        return NetworkFailure(
          fallbackMessage ??
              'No internet connection. Please check your network.',
        );

      case DioExceptionType.cancel:
        return ClientFailure(fallbackMessage ?? 'Request cancelled');

      default:
        return ServerFailure(
          e.message ?? fallbackMessage ?? 'Something went wrong',
        );
    }
  }

  /// Handle bad response based on status code
  static Failure _handleBadResponse(DioException e, {String? fallbackMessage}) {
    final statusCode = e.response?.statusCode;
    final responseData = e.response?.data;

    // Try to extract error message from response
    String? errorMessage;
    if (responseData is Map<String, dynamic>) {
      errorMessage =
          responseData['message'] as String? ??
          responseData['error'] as String?;
    }

    switch (statusCode) {
      case 400:
        return ClientFailure(errorMessage ?? fallbackMessage ?? 'Bad request');

      case 401:
        return ClientFailure(
          errorMessage ??
              fallbackMessage ??
              'Unauthorized. Please login again.',
        );

      case 403:
        return ClientFailure(
          errorMessage ??
              fallbackMessage ??
              'Forbidden. You don\'t have permission.',
        );

      case 404:
        return ClientFailure(
          errorMessage ?? fallbackMessage ?? 'Resource not found',
        );

      case 422:
        return ClientFailure(
          errorMessage ?? fallbackMessage ?? 'Validation error',
        );

      case 500:
        return ServerFailure(
          fallbackMessage ?? 'Server error. Please try again later.',
        );

      case 502:
        return ServerFailure(
          fallbackMessage ?? 'Bad gateway. Server is unreachable.',
        );

      case 503:
        return ServerFailure(
          fallbackMessage ?? 'Service unavailable. Try again later.',
        );

      default:
        return ClientFailure(
          errorMessage ?? fallbackMessage ?? 'Request failed',
        );
    }
  }

  /// Handle generic exceptions
  static Failure handleException(Object e, String? fallbackMessage) {
    if (e is DioException) {
      return handleDioException(e, fallbackMessage: fallbackMessage);
    }
    return UnexpectedFailure(
      fallbackMessage ?? 'Unexpected error: ${e.toString()}',
    );
  }
}
