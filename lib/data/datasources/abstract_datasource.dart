import 'dart:async';

import 'package:currency_calculator/data/models/currency_converter/currency_model.dart';
import 'package:currency_calculator/data/models/currency_converter/currency_rate_model.dart';
import 'package:currency_calculator/data/models/currency_details/currency_rate_by_date_model.dart';
import 'package:currency_calculator/data/models/history/history_model.dart';
import 'package:currency_calculator/data/models/history/history_result_item_model.dart';

abstract class AbstractDataSource {
  Future<List<CurrencyModel>> getSupportedCurrencies();
  Future<List<CurrencyRateModel>> getExchangeRates({
    required int exchangeId,
    required String baseCurrency,
  });
  Future<void> addRatesToHistory({
    required int exchangeId,
    required String? exchangeTitle,
    required String currencyCodeFrom,
    required String? currencyNameFrom,
    required String? currencyCodeTo,
    required String? currencyNameTo,
    required double? value,
    required List<HistoryResultItemModel> items,
  });
  Future<List<HistoryModel>> getRatesHistory({int limit = 100});
  FutureOr<List<CurrencyRateByDateModel>> getExchangeCurrencyByDate({
    required int exchangeId,
    required String currencyBase,
    required String currencyTo,
    required DateTime dateFrom,
    required DateTime dateTo,
  });
}
