import 'package:ehentter/core/di/injection_container.dart';
import 'package:ehentter/core/exceptions/eh_exceptions.dart';
import 'package:ehentter/core/logger/logger.dart';
import 'package:html/dom.dart';
import 'package:meta/meta.dart';

/// [I] 原始数据类型
/// [T] 返回类型
abstract class EhBaseParser<I, T> {
  final ILoggerService _logger = sl();

  T call(I input) {
    try {
      return parser(input);
    } catch (e, stackTrace) {
      if (e is EhParseException) {
        _logger.e('Parser error: ${e.parser}', error: e);
        rethrow;
      }

      final exception = EhParseException(
        e,
        stackTrace: stackTrace,
        parser: runtimeType,
        rawData: _formatRawData(input),
      );

      _logger.e('Unexpected parsing error: $runtimeType', error: exception);
      throw exception;
    }
  }

  @protected
  T parser(I input);

  String _formatRawData(I input) {
    return switch (input) {
      Document document => document.outerHtml,
      Element element => element.outerHtml,
      _ => input.toString(),
    };
  }
}
