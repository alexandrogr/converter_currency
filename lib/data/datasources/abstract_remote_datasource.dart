import 'dart:async';

import 'package:currency_calculator/data/models/currency_converter/currency_model.dart';
import 'package:currency_calculator/data/models/currency_converter/currency_rate_model.dart';
import 'package:currency_calculator/data/models/currency_details/currency_rate_by_date_model.dart';

abstract class AbstractRemoteDataSource {
  Future<List<CurrencyModel>> getSupportedCurrencies();
  Future<List<CurrencyRateModel>> getExchangeRates({
    required int exchangeId,
    required String baseCurrency,
  });

  FutureOr<List<CurrencyRateByDateModel>> getExchangeCurrencyByDate({
    required int exchangeId,
    required String currencyBase,
    required String currencyTo,
    required DateTime dateFrom,
    required DateTime dateTo,
  });
}
