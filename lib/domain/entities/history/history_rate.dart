import 'package:currency_calculator/domain/entities/currency_converter/currency_rate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_rate.freezed.dart';
part 'history_rate.g.dart';

@freezed
class HistoryRate with _$HistoryRate {
  HistoryRate._();
  factory HistoryRate({
    int? exchangeId,
    String? exchangeTitle,
    String? currencyCodeFrom,
    String? currencyNameFrom,
    String? currencyCodeTo,
    String? currencyNameTo,
    @Default(0.0) double value,
    @Default([]) List<CurrencyRate> items,
    DateTime? createdAt,
  }) = _HistoryRate;

  factory HistoryRate.fromJson(Map<String, dynamic> json) =>
      _$HistoryRateFromJson(json);

  /// Parses a list of JSON objects into a list of `HistoryRate` instances
  static List<HistoryRate> fromJsonItems(List<dynamic> jsonList) {
    return jsonList
        .map((json) => HistoryRate.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
