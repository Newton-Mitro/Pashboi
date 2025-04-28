import 'package:logger/logger.dart';
import 'logger_service.dart';

class LoggerServiceImpl implements LoggerService {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Shows method calls in stack trace
      errorMethodCount: 5, // Shows method calls in case of an error
      lineLength: 80, // Wrap lines at 80 characters
      colors: true, // Enable colors for logs
      printEmojis: true, // Enable emojis for better readability
      dateTimeFormat: DateTimeFormat.dateAndTime, // Show timestamps in logs
    ),
  );

  @override
  void logInfo(String message) {
    _logger.i(message);
  }

  @override
  void logWarning(String message) {
    _logger.w(message);
  }

  @override
  void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  @override
  void logDebug(String message) {
    _logger.d(message);
  }

  @override
  void logFatal(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  @override
  void logTrace(String message) {
    _logger.t(message);
  }
}
