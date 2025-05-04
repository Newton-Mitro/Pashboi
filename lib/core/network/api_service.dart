import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pashboi/core/constants/api_config.dart';
import 'package:pashboi/core/errors/exceptions.dart';
import 'package:pashboi/core/logging/logger_service.dart';
import 'package:pashboi/core/network/logger_interceptor.dart';
import 'package:pashboi/core/utils/local_storage.dart';

class ApiService {
  final Dio _dio;
  final LocalStorage localStorage;
  final LoggerService loggerService;

  ApiService({required this.localStorage, required this.loggerService})
    : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(seconds: 50),
    );
    _dio.interceptors.addAll([LoggerInterceptor(loggerService: loggerService)]);
  }

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _performRequest(
      () => _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options ?? Options(),
      ),
    );
  }

  Future<Response> post(
    String endpoint, {
    required Map<String, dynamic> data,
    Options? options,
  }) async {
    return _performRequest(
      () => _dio.post(endpoint, data: data, options: options ?? Options()),
    );
  }

  Future<Response> put(
    String endpoint, {
    required Map<String, dynamic> data,
    Options? options,
  }) async {
    return _performRequest(
      () => _dio.put(endpoint, data: data, options: options ?? Options()),
    );
  }

  Future<Response> patch(
    String endpoint, {
    required Map<String, dynamic> data,
    Options? options,
  }) async {
    return _performRequest(
      () => _dio.patch(endpoint, data: data, options: options ?? Options()),
    );
  }

  Future<Response> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _performRequest(
      () => _dio.delete(
        endpoint,
        queryParameters: queryParameters,
        options: options ?? Options(),
      ),
    );
  }

  Future<Response> _performRequest(Future<Response> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  void _handleDioError(DioException e) {
    final statusCode = e.response?.statusCode;
    switch (statusCode) {
      case HttpStatus.badRequest:
        final Map<String, dynamic>? errorResponse = e.response?.data;
        if (errorResponse != null) {
          final errors = errorResponse['errors'] as Map<String, dynamic>;
          throw ValidationException(errors: errors);
        }
        break;
      case HttpStatus.unauthorized:
        throw UnauthorizedException();
      case HttpStatus.forbidden:
        throw ForbiddenException();
      case HttpStatus.internalServerError:
        throw ServerException();
      default:
        throw Exception(e.message);
    }
  }
}
