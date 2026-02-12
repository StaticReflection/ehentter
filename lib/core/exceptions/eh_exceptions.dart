class EhException implements Exception {
  final Object message;
  EhException(this.message);
  @override
  String toString() => 'EhException: $message';
}

class EhParseException extends EhException {
  EhParseException(super.message);

  @override
  String toString() => 'EhParseException: $message';
}
