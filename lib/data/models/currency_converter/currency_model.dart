import 'package:currency_calculator/core/database/local_database.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_model.freezed.dart';
part 'currency_model.g.dart';

@freezed
class CurrencyModel with _$CurrencyModel {
  const CurrencyModel._();
  factory CurrencyModel({
    required String currencyCode,
    String? currencyName,
    String? countryCode,
    String? countryName,
    String? status,
    DateTime? availableFrom,
    String? availableUntil,
    String? icon,
  }) = _CurrencyModel;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyModelFromJson(json);

  /// Parses a list of JSON objects into a list of `CurrencyModel` instances
  static List<CurrencyModel> fromJsonItems(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CurrencyModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  factory CurrencyModel.fromDatabase(SupportedCurrencyTableData data) =>
      CurrencyModel(
        currencyCode: data.currencyCode,
        currencyName: data.currencyName,
        countryCode: data.countryCode,
        countryName: data.countryName,
      );

  Currency toEntity() => Currency(
      currencyCode: currencyCode,
      currencyName: currencyName,
      countryCode: countryCode,
      countryName: countryName);

  bool get isAvailable => status == "AVAILABLE";
}
