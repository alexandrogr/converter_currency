import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_details_state_data.freezed.dart';

@freezed
class CurrencyDetailsStateData with _$CurrencyDetailsStateData {
  CurrencyDetailsStateData._();
  factory CurrencyDetailsStateData({
    required int exchangeId,
    required String currencyCodeBase,
    required String currencyCodeTo,
    required DateTime month,
  }) = _CurrencyDetailsStateData;

  factory CurrencyDetailsStateData.forCurrentMonth({
    required int exchangeId,
    required String currencyCodeBase,
    required String currencyCodeTo,
  }) {
    final DateTime now = DateTime.now();
    return CurrencyDetailsStateData(
      exchangeId: exchangeId,
      currencyCodeBase: currencyCodeBase,
      currencyCodeTo: currencyCodeTo,
      month: DateTime(now.year, now.month, now.day),
    );
  }

  CurrencyDetailsStateData forNextMonth() {
    return copyWith(
      month: month.copyWith(month: month.month + 1),
    );
  }

  CurrencyDetailsStateData forPrevMonth() {
    return copyWith(
      month: month.copyWith(month: month.month - 1),
    );
  }

  bool get hasNextMonth {
    int nextMonth = month.month + 1;
    int nextYear = month.year;

    if (nextMonth > 12) {
      nextMonth = 1;
      nextYear += 1;
    }

    return DateTime(nextYear, nextMonth, 1).isAfter(month);
  }
}
