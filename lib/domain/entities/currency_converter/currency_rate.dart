import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_rate.freezed.dart';
part 'currency_rate.g.dart';

@freezed
class CurrencyRate with _$CurrencyRate {
  const CurrencyRate._();
  factory CurrencyRate({
    required String code,
    required String name,
    @Default(0.0) double rate,
    @Default(1.0) double value,
    Currency? currency,
  }) = _CurrencyRate;

  factory CurrencyRate.fromJson(Map<String, dynamic> json) =>
      _$CurrencyRateFromJson(json);

  /// Parses a list of JSON objects into a list of `CurrencyRate` instances
  static List<CurrencyRate> fromJsonItems(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CurrencyRate.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  double get valueByRate => value * rate;
}
