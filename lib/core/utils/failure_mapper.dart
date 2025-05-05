import 'dart:io';
import 'package:dio/dio.dart';
import 'package:pashboi/core/errors/error_message.dart';
import 'package:pashboi/core/errors/failures.dart';

class FailureMapper {
  static Failure fromException(Object exception) {
    if (exception is DioException) {
      final dioError = exception;

      switch (dioError.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return NetworkFailure(message: ErrorMessage.timeout, statusCode: 408);

        case DioExceptionType.badResponse:
          final statusCode = dioError.response?.statusCode ?? 500;
          final data = dioError.response?.data;

          switch (statusCode) {
            case 400:
              return ValidationFailure(
                errors: _extractValidationErrors(data),
                statusCode: statusCode,
              );
            case 401:
              return UnauthorizedFailure(statusCode: statusCode);
            case 403:
              return ForbiddenFailure(statusCode: statusCode);
            case 500:
            default:
              return ServerFailure(statusCode: statusCode);
          }

        case DioExceptionType.cancel:
          return const RequestCancelledFailure(
            message: "Request was cancelled",
            statusCode: -4,
          );

        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
        default:
          return NetworkFailure(statusCode: -1);
      }
    } else if (exception is SocketException) {
      return NetworkFailure(statusCode: -1);
    } else {
      return ServerFailure(message: exception.toString(), statusCode: 500);
    }
  }

  static Map<String, dynamic> _extractValidationErrors(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey('errors')) {
      return data['errors'] as Map<String, dynamic>;
    }
    return {'error': 'Invalid request'};
  }
}
