import 'package:currency_calculator/core/database/local_database.dart';
import 'package:currency_calculator/data/models/history/history_result_item_model.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency_rate.dart';
import 'package:currency_calculator/domain/entities/history/history_rate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_model.freezed.dart';
part 'history_model.g.dart';

@freezed
class HistoryModel with _$HistoryModel {
  HistoryModel._();
  factory HistoryModel({
    String? currencyCodeFrom,
    String? currencyNameFrom,
    String? currencyCodeTo,
    String? currencyNameTo,
    int? exchangeId,
    String? exchangeTitle,
    @Default(0.0) double value,
    @Default([]) List<HistoryResultItemModel> items,
    DateTime? createdAt,
  }) = _HistoryModel;

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  /// Parses a list of JSON objects into a list of `HistoryModel` instances
  static List<HistoryModel> fromJsonItems(List<dynamic> jsonList) {
    return jsonList
        .map((json) => HistoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  factory HistoryModel.fromDatabase(HistoryTableData data) => HistoryModel(
      currencyCodeFrom: data.currencyCodeFrom,
      currencyNameFrom: data.currencyNameFrom,
      currencyCodeTo: data.currencyCodeTo,
      currencyNameTo: data.currencyNameTo,
      exchangeId: data.exchangeId,
      exchangeTitle: data.exchangeTitle,
      value: data.value ?? 0.0,
      items: data.result != null
          ? HistoryResultItemModel.deserializeList(data.result!)
          : [],
      createdAt: data.createdAt);

  HistoryRate toEntity() => HistoryRate(
        currencyCodeFrom: currencyCodeFrom,
        currencyNameFrom: currencyNameFrom,
        currencyCodeTo: currencyCodeTo,
        currencyNameTo: currencyNameTo,
        exchangeId: exchangeId,
        exchangeTitle: exchangeTitle,
        value: value,
        items: items
            .map((e) => CurrencyRate(
                  code: e.currencyCodeTo ?? "-",
                  name: e.currencyNameTo ?? "-",
                  value: e.value ?? 0.0,
                  rate: e.rate ?? 0.0,
                  currency: Currency(
                      currencyCode: e.currencyCodeFrom ?? "-",
                      currencyName: e.currencyNameFrom,
                      countryCode: "",
                      countryName: ""),
                ))
            .toList(),
        createdAt: createdAt,
      );
}
