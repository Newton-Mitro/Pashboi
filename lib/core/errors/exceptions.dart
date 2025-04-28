import 'package:pashboi/core/errors/error_message.dart';

class ServerException implements Exception {
  final String message;
  ServerException({this.message = ErrorMessage.serverError});

  @override
  String toString() => "ServerException: $message";
}

class CacheException implements Exception {
  final String message;
  CacheException({this.message = ErrorMessage.cacheError});

  @override
  String toString() => "CacheException: $message";
}

class ValidationException implements Exception {
  final Map<String, dynamic> errors;
  final String message;
  ValidationException({
    required this.errors,
    this.message = ErrorMessage.serverError,
  });

  @override
  String toString() => "ValidationException: $errors";
}

class NetworkException implements Exception {
  final String message;
  NetworkException({this.message = ErrorMessage.noInternet});

  @override
  String toString() => "NetworkException: $message";
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException({this.message = ErrorMessage.unauthorized});

  @override
  String toString() => "UnauthorizedException: $message";
}

class ForbiddenException implements Exception {
  final String message;
  ForbiddenException({this.message = ErrorMessage.forbidden});

  @override
  String toString() => "ForbiddenException: $message";
}
