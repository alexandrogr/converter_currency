import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:currency_calculator/domain/entities/exchange/exchange.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state_data.freezed.dart';

@freezed
class SettingsStateData with _$SettingsStateData {
  SettingsStateData._();
  factory SettingsStateData({
    @Default([]) List<Exchange> excahnges,
    Exchange? selectedExcahnge,
    @Default([]) List<Currency> currencies,
  }) = _SettingsStateData;

  bool get selectedExcangeIsNotNull => selectedExcahnge != null;
}
