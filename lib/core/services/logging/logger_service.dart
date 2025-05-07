abstract class LoggerService {
  void logInfo(String message);
  void logWarning(String message);
  void logError(String message, [dynamic error, StackTrace? stackTrace]);
  void logDebug(String message);
  void logFatal(String message, [dynamic error, StackTrace? stackTrace]);
  void logTrace(String message);
}
