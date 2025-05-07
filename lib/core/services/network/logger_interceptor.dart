import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pashboi/core/services/logging/logger_service.dart';

class LoggerInterceptor extends Interceptor {
  final LoggerService loggerService;

  LoggerInterceptor({required this.loggerService});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final buffer = StringBuffer();
    buffer.writeln("╔════════════════════════════════════════");
    buffer.writeln("║ 📤 REQUEST: ${options.method} ${options.uri}");
    buffer.writeln("║ Headers: ${jsonEncode(options.headers)}");

    if (options.data != null) {
      try {
        buffer.writeln("║ Body: ${_prettyJson(options.data)}");
      } catch (_) {
        buffer.writeln("║ Body: ${options.data}");
      }
    }
    buffer.writeln("╚════════════════════════════════════════");

    loggerService.logInfo(buffer.toString());
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final buffer = StringBuffer();
    buffer.writeln("╔════════════════════════════════════════");
    buffer.writeln(
      "║ ✅ RESPONSE [${response.statusCode}]: ${response.requestOptions.uri}",
    );
    buffer.writeln("║ Headers: ${jsonEncode(response.headers.map)}");

    try {
      buffer.writeln("║ Data: ${_prettyJson(response.data)}");
    } catch (_) {
      buffer.writeln("║ Data: ${response.data}");
    }
    buffer.writeln("╚════════════════════════════════════════");

    loggerService.logDebug(buffer.toString());
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final buffer = StringBuffer();
    buffer.writeln("╔════════════════════════════════════════");
    buffer.writeln(
      "║ ❌ ERROR [${err.response?.statusCode}]: ${err.requestOptions.uri}",
    );
    buffer.writeln("║ Message: ${err.message}");

    if (err.response != null) {
      try {
        buffer.writeln("║ Error Data: ${_prettyJson(err.response?.data)}");
      } catch (_) {
        buffer.writeln("║ Error Data: ${err.response?.data}");
      }
    }
    buffer.writeln("╚════════════════════════════════════════");

    loggerService.logError(buffer.toString());
    handler.next(err);
  }

  String _prettyJson(dynamic json) {
    try {
      return const JsonEncoder.withIndent('  ').convert(json);
    } catch (_) {
      return json.toString();
    }
  }
}
