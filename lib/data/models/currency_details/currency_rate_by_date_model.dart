// class CurrencyRateByDateModel extends CurrencyRateByDate {}

import 'package:currency_calculator/domain/entities/currency_details/currency_rate_by_date.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_rate_by_date_model.freezed.dart';
part 'currency_rate_by_date_model.g.dart';

@freezed
class CurrencyRateByDateModel with _$CurrencyRateByDateModel {
  CurrencyRateByDateModel._();
  factory CurrencyRateByDateModel({
    required String currencyCodeFrom,
    required String currencyCodeTo,
    required DateTime date,
    @Default(0.0) double value,
  }) = _CurrencyRateByDateModel;

  factory CurrencyRateByDateModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyRateByDateModelFromJson(json);

  /// Parses a list of JSON objects into a list of `CurrencyRateByDateModel` instances
  static List<CurrencyRateByDateModel> fromJsonItems(List<dynamic> jsonList) {
    return jsonList
        .map((json) =>
            CurrencyRateByDateModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  CurrencyRateByDate toEntity() => CurrencyRateByDate(
        currencyCodeFrom: currencyCodeFrom,
        currencyCodeTo: currencyCodeTo,
        date: date,
        value: value,
      );
}
