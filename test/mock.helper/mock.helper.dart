import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:pashboi/core/network/auth_interceptor.dart';
import 'package:pashboi/core/network/logger_interceptor.dart';
import 'package:pashboi/core/network/network_info.dart';
import 'package:pashboi/core/utils/local_storage.dart';

@GenerateMocks([
  NetworkInfo,
  Dio,
  LocalStorage,
  LoggerInterceptor,
  AuthInterceptor,
])
void main() {}
