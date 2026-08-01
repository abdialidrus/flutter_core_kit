import 'package:core_kit/src/data/result.dart';

abstract class UseCase<ReturnType, Params> {
  Future<Result<ReturnType>> call(Params params);
}

abstract class StreamUseCase<ReturnType, Params> {
  Stream<ReturnType> call(Params params);
}

/// Placeholder parameter class for use cases that require no input.
class NoParams {
  const NoParams();
}
