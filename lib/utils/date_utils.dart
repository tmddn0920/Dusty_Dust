class DateUtils {
  static DateTimeToString({
    required DateTime datetime,
  }) {
    return '${datetime.year}-${padInteger(number: datetime.month)}-${padInteger(number: datetime.day)} ${padInteger(number: datetime.hour)}:00';
  }

  static String padInteger({
    required int number,
  }) {
    return number.toString().padLeft(2, '0');
  }
}
