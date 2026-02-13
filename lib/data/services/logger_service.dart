import 'package:ehentter/core/logger/logger.dart';
import 'package:logger/logger.dart';

class LoggerService implements ILoggerService {
  late final Logger _logger;

  Future<void> init() async {
    _logger = Logger(printer: SimplePrinter());
  }

  @override
  void d(String message) {
    _logger.d(message);
  }

  @override
  void i(String message) {
    _logger.i(message);
  }

  @override
  void w(String message) {
    _logger.w(message);
  }

  @override
  void e(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
