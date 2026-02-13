abstract class ILoggerService {
  void d(String message);
  void i(String message);
  void w(String message);
  void e(String message, {Object? error, StackTrace? stackTrace});
}
