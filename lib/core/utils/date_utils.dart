/// Calendar helpers built on UTC midnight for date-only comparisons.
extension AppDateTime on DateTime {
  DateTime get startOfDay => DateTime.utc(year, month, day);
  DateTime get startOfMonth => DateTime.utc(year, month, 1);
  DateTime get endOfMonth => DateTime.utc(year, month + 1, 0);
  DateTime get startOfNextMonth => DateTime.utc(year, month + 1, 1);
  DateTime get startOfPreviousMonth => DateTime.utc(year, month - 1, 1);
}

/// A stable year-month key (e.g. `2026-09`) used for budgets and reports.
String monthKey(DateTime date) {
  final m = date.month.toString().padLeft(2, '0');
  return '${date.year}-$m';
}

/// Whether [date] falls within [start] (inclusive) and [end] (exclusive).
bool isWithinRange(DateTime date, DateTime start, DateTime end) {
  final d = date.startOfDay;
  return !d.isBefore(start.startOfDay) && d.isBefore(end.startOfDay);
}
