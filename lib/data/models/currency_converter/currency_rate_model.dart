import 'package:currency_calculator/domain/entities/currency_converter/currency_rate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_rate_model.freezed.dart';
part 'currency_rate_model.g.dart';

@freezed
class CurrencyRateModel with _$CurrencyRateModel {
  CurrencyRateModel._();
  factory CurrencyRateModel({
    required String code,
    required String name,
    @Default(0.0) double rate,
  }) = _CurrencyRateModel;

  factory CurrencyRateModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyRateModelFromJson(json);

  CurrencyRate toEntity() => CurrencyRate(
        code: code,
        name: name,
        rate: rate,
      );
}
