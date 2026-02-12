class EhJsonConverters {
  static DateTime dateTimeFromTimestamp(dynamic v) {
    if (v == null) return DateTime.now();
    final timestamp = int.tryParse(v.toString()) ?? 0;
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }
}
