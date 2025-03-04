import 'package:intl/intl.dart';

class NumberHelper {
  static String numberFormat(double? value) {
    // return AppConst.getNumberFormat(value);
    // return NumberFormat("#,##0.00", "en_US").format(value);
    return NumberFormat("#,##0.00").format(value ?? 0.0);
  }
}
