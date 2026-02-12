class EhException implements Exception {
  final Object message;
  EhException(this.message);
  @override
  String toString() => 'EhException: $message';
}

class EhParseException extends EhException {
  final StackTrace stackTrace;
  final Type parser; // 解析器类名
  final String rawData; // 原始输入

  EhParseException(
    super.message, {
    required this.stackTrace,
    required this.parser,
    required this.rawData,
  });

  @override
  String toString() =>
      'EhParseException[$parser]: $message\n'
      'StackTrace: $stackTrace\n'
      '$rawData';
}
