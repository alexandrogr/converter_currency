import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_rate_by_date.freezed.dart';
part 'currency_rate_by_date.g.dart';

@freezed
class CurrencyRateByDate with _$CurrencyRateByDate {
  CurrencyRateByDate._();
  factory CurrencyRateByDate({
    required String currencyCodeFrom,
    required String currencyCodeTo,
    required DateTime date,
    @Default(0.0) double value,
  }) = _CurrencyRateByDate;

  factory CurrencyRateByDate.fromJson(Map<String, dynamic> json) =>
      _$CurrencyRateByDateFromJson(json);

  bool get forCurrentYear => date.year == DateTime.now().year;
}
