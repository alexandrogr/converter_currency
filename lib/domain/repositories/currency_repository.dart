import 'dart:async';

import 'package:currency_calculator/core/network/data_priority.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency_rate.dart';
import 'package:currency_calculator/domain/entities/currency_details/currency_rate_by_date.dart';
import 'package:currency_calculator/domain/entities/exchange/exchange.dart';
import 'package:currency_calculator/domain/entities/history/history_rate.dart';

abstract class CurrencyRepository {
  DataPriority get defaultPrority;
  FutureOr<List<Exchange>> getSupportedExchanges();
  FutureOr<List<Currency>> getSupportedCurrencies({
    required int exchangeId,
  });

  // rates
  FutureOr<List<CurrencyRate>> getExchangeRates(
      Exchange exchange, String baseCurrency);
  FutureOr<List<CurrencyRateByDate>> getExchangeCurrencyDetails({
    required int exchangeId,
    required String cyrrencyBase,
    required String currencyTo,
    required DateTime month,
  });

  // history
  FutureOr<bool> addRatesToHistory({
    required Exchange exchange,
    required Currency currencyFrom,
    required Currency? currencyTo,
    required double? value,
    required List<CurrencyRate> items,
  });
  FutureOr<List<HistoryRate>>
      getHistoryRates(); // add pagination and limit, offset in the future
}
