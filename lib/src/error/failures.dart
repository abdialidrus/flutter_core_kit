/// Base class for all failures.
abstract class Failure {
  final String message;

  const Failure(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() => '$runtimeType($message)';
}

/// Server failure (5xx errors).
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

/// Network failure (no internet connection).
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

/// Client failure (4xx errors).
class ClientFailure extends Failure {
  const ClientFailure([super.message = 'Client error occurred']);
}

/// Cache failure (local storage errors).
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred']);
}

/// Unexpected failure.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'Unexpected error occurred']);
}

/// Not found failure.
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Data not found']);
}

/// Invalid operation failure.
class InvalidOperationFailure extends Failure {
  const InvalidOperationFailure([super.message = 'Invalid operation']);
}

/// Failure related to location services or permissions.
class LocationFailure extends Failure {
  const LocationFailure([super.message = 'A location service error occurred.']);
}

/// Failure related to the background service lifecycle.
class ServiceFailure extends Failure {
  const ServiceFailure([
    super.message = 'A background service error occurred.',
  ]);
}

/// Failure when location permissions are denied.
class PermissionDeniedFailure extends Failure {
  const PermissionDeniedFailure([
    super.message = 'Location permission was denied.',
  ]);
}

/// Failure when location permissions are permanently denied and
/// the user must open app settings to grant them.
class PermissionPermanentlyDeniedFailure extends Failure {
  const PermissionPermanentlyDeniedFailure([
    super.message =
        'Location permission is permanently denied. '
        'Please enable it from app settings.',
  ]);
}
