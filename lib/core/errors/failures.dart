import 'package:equatable/equatable.dart';
import 'package:pashboi/core/errors/error_message.dart';

/// Base Failure class
abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  const Failure({required this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// Validation failure with field-level errors
final class ValidationFailure extends Failure {
  final Map<String, dynamic> errors;

  const ValidationFailure({
    required this.errors,
    super.statusCode = 422,
    super.message = ErrorMessage.validationError,
  });

  @override
  List<Object?> get props => [message, statusCode, errors];
}

final class RequestCancelledFailure extends Failure {
  const RequestCancelledFailure({
    super.message = ErrorMessage.requestCancelled,
    required super.statusCode,
  });
}

/// Server-side failure
final class ServerFailure extends Failure {
  const ServerFailure({
    super.statusCode = 500,
    super.message = ErrorMessage.serverError,
  });
}

/// Cache-related failure
final class CacheFailure extends Failure {
  const CacheFailure({
    super.statusCode = -2,
    super.message = ErrorMessage.cacheError,
  });
}

/// Network-related failure (e.g., no internet)
final class NetworkFailure extends Failure {
  const NetworkFailure({
    super.statusCode = -1,
    super.message = ErrorMessage.noInternet,
  });
}

final class NoInternetFailure extends Failure {
  const NoInternetFailure({
    super.statusCode = -1,
    super.message = ErrorMessage.noInternet,
  });
}

/// Unauthorized access (401)
final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.statusCode = 401,
    super.message = ErrorMessage.unauthorized,
  });
}

/// Forbidden access (403)
final class ForbiddenFailure extends Failure {
  const ForbiddenFailure({
    super.statusCode = 403,
    super.message = ErrorMessage.forbidden,
  });
}
