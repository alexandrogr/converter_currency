import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency.freezed.dart';
part 'currency.g.dart';

@freezed
class Currency with _$Currency {
  const Currency._();
  factory Currency({
    required String currencyCode,
    required String? currencyName,
    required String? countryCode,
    required String? countryName,
  }) = _Currency;

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  /// Parses a list of JSON objects into a list of `Currency` instances
  static List<Currency> fromJsonItems(List<dynamic> jsonList) {
    return jsonList
        .map((json) => Currency.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
