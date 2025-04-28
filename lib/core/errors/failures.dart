import 'package:equatable/equatable.dart';
import 'package:pashboi/core/errors/error_message.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

final class ValidationFailure extends Failure {
  final Map<String, dynamic> errors;

  const ValidationFailure(
    this.errors, {
    super.message = ErrorMessage.validationError,
  });

  @override
  List<Object?> get props => [message, errors];
}

final class ServerFailure extends Failure {
  const ServerFailure({super.message = ErrorMessage.serverError});
}

final class CacheFailure extends Failure {
  const CacheFailure({super.message = ErrorMessage.cacheError});
}

final class NetworkFailure extends Failure {
  const NetworkFailure({super.message = ErrorMessage.noInternet});
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message = ErrorMessage.unauthorized});
}

final class ForbiddenFailure extends Failure {
  const ForbiddenFailure({super.message = ErrorMessage.forbidden});
}
