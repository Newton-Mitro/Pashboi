import 'package:dio/dio.dart';
import 'package:pashboi/core/constants/api_config.dart';
import 'package:pashboi/core/services/logging/logger_service.dart';
import 'package:pashboi/core/services/network/logger_interceptor.dart';

class ProductApiService {
  final Dio _dio;
  final LoggerService loggerService;

  ProductApiService({required this.loggerService}) : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: AppConfig.productApiUrl,
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
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
