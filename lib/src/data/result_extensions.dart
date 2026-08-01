import 'package:core_kit/src/data/result.dart';
import 'package:core_kit/src/error/failures.dart';

/// Convenience extensions on [Result] for common transformations.
extension ResultExtensions<T> on Result<T> {
  /// Returns the success value or throws the [Failure] if this is an error.
  T get valueOrThrow => switch (this) {
    Ok(:final value) => value,
    Error(:final failure) => throw failure,
  };

  /// Returns the success value, or `null` if this is an error.
  T? get valueOrNull => switch (this) {
    Ok(:final value) => value,
    Error() => null,
  };

  /// Returns the [Failure] if this is an error, or `null` if successful.
  Failure? get failureOrNull => switch (this) {
    Ok() => null,
    Error(:final failure) => failure,
  };

  /// Whether this result is a success ([Ok]).
  bool get isOk => this is Ok<T>;

  /// Whether this result is a failure ([Error]).
  bool get isError => this is Error<T>;

  /// Transforms the success value using [transform]. Errors pass through.
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Ok(:final value) => Result.ok(transform(value)),
    Error(:final failure) => Result.error(failure),
  };

  /// Transforms the success value using [transform] which itself returns
  /// a [Result]. Useful for chaining operations that can fail.
  Result<R> flatMap<R>(Result<R> Function(T value) transform) =>
      switch (this) {
        Ok(:final value) => transform(value),
        Error(:final failure) => Result.error(failure),
      };

  /// Calls [onOk] for success or [onError] for failure, returning
  /// the result of whichever branch was taken.
  R fold<R>({
    required R Function(T value) onOk,
    required R Function(Failure failure) onError,
  }) =>
      switch (this) {
        Ok(:final value) => onOk(value),
        Error(:final failure) => onError(failure),
      };
}
