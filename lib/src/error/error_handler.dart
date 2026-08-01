import 'package:core_kit/src/error/failures.dart';
import 'package:dio/dio.dart';

/// Centralized error handler for Dio exceptions
/// Converts DioException to appropriate Failure types
class ErrorHandler {
  /// Handle Dio exceptions and convert to Failure
  static Failure handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout. Please try again.');

      case DioExceptionType.badResponse:
        return _handleBadResponse(e);

      case DioExceptionType.connectionError:
        return const NetworkFailure(
          'No internet connection. Please check your network.',
        );

      case DioExceptionType.cancel:
        return const ClientFailure('Request cancelled');

      default:
        return ServerFailure(e.message ?? 'Something went wrong');
    }
  }

  /// Handle bad response based on status code
  static Failure _handleBadResponse(DioException e) {
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
        return ClientFailure(errorMessage ?? 'Bad request');

      case 401:
        return ClientFailure(
          errorMessage ?? 'Unauthorized. Please login again.',
        );

      case 403:
        return const ClientFailure('Forbidden. You don\'t have permission.');

      case 404:
        return ClientFailure(errorMessage ?? 'Resource not found');

      case 422:
        return ClientFailure(errorMessage ?? 'Validation error');

      case 500:
        return const ServerFailure('Server error. Please try again later.');

      case 502:
        return const ServerFailure('Bad gateway. Server is unreachable.');

      case 503:
        return const ServerFailure('Service unavailable. Try again later.');

      default:
        return ClientFailure(errorMessage ?? 'Request failed');
    }
  }

  /// Handle generic exceptions
  static Failure handleException(Object e) {
    if (e is DioException) {
      return handleDioException(e);
    }
    return UnexpectedFailure('Unexpected error: ${e.toString()}');
  }
}
