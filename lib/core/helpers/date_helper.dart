import 'package:intl/intl.dart';

class DateHelper {
  static DateFormat defaultFormattedDate = DateFormat('dd MMMM yyyy, HH:mm');

  static formatDate(DateTime date) => defaultFormattedDate.format(date);
  static formatDateWithoutTime(DateTime date) =>
      DateFormat('dd MMMM yyyy').format(date);
  static formatDateWithoutTimeAndYear(DateTime date) =>
      DateFormat('dd MMMM').format(date);

  static systemFormat(DateTime date) => DateFormat('yyyy.MM.dd').format(date);
}
