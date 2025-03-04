import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:currency_calculator/domain/entities/exchange/exchange.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_state_data.freezed.dart';

@freezed
class FilterStateData with _$FilterStateData {
  FilterStateData._();
  factory FilterStateData({
    Exchange? exchange,
    Currency? fromCurrency,
    Currency? toCurrency,
    double? value,
  }) = _FilterStateData;

  bool get isSelectedBaseCurrency => fromCurrency != null;
  bool get isSelectedConvertedCurrency => toCurrency != null;
  bool get isSelectedCurrencies =>
      isSelectedBaseCurrency && isSelectedConvertedCurrency;
  bool get hasValue => (value ?? 0.0) > 0.0;
  bool get isFilled => isSelectedCurrencies && hasValue;
}
