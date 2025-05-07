import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:pashboi/core/services/network/logger_interceptor.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/utils/local_storage.dart';

@GenerateMocks([NetworkInfo, Dio, LocalStorage, LoggerInterceptor])
void main() {}
