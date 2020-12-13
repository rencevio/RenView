extension DateTimeYMD on DateTime {
  String _pad(int n) => n > 9 ? n.toString() : '0$n';
  String get yearMonthDay => '$year-${_pad(month)}-${_pad(day)}';
}
