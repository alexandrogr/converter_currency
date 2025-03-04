import 'dart:async';

import 'package:currency_calculator/core/network/data_priority.dart';
import 'package:currency_calculator/core/utils/log_mixin.dart';
import 'package:currency_calculator/data/datasources/local/local_datasource_impl.dart';
import 'package:currency_calculator/data/datasources/remote/remote_datasource_demo.dart';
import 'package:currency_calculator/data/models/history/history_result_item_model.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency_rate.dart';
import 'package:currency_calculator/domain/entities/currency_details/currency_rate_by_date.dart';
import 'package:currency_calculator/domain/entities/exchange/exchange.dart';
import 'package:currency_calculator/domain/entities/history/history_rate.dart';
import 'package:currency_calculator/domain/repositories/currency_repository.dart';
import 'package:currency_calculator/injectable.dart';
import 'package:injectable/injectable.dart';

// if need change to dev/prod
@Injectable(as: CurrencyRepository, env: [Env.demo])
class CurrencyRepositoryDemo with LogMixin implements CurrencyRepository {
  final RemoteDataSourceDemo remoteDataSource;
  final LocalDataSourceImpl localDataSource;

  CurrencyRepositoryDemo(this.remoteDataSource, this.localDataSource);

  @override
  DataPriority get defaultPrority => DataPriority.remote;

  @override
  FutureOr<List<Currency>> getSupportedCurrencies({
    required int exchangeId,
  }) async {
    logMessageWithPrefix(
      "Loading ...",
      prefix: getCurrentMethodNameLog(),
      isGroup: true,
    );

    try {
      if (defaultPrority == DataPriority.remote) {
        return await _getRemoteSupportedCurrencies(
          exchangeId: exchangeId,
        );
      } else {
        return await _getLocalSupportedCurrencies(
          exchangeId: exchangeId,
        );
      }
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      rethrow;
    }
  }

  FutureOr<List<Currency>> _getRemoteSupportedCurrencies({
    required int exchangeId,
    bool fromLocalRequest = false,
  }) async {
    try {
      // await localDataSource.clearSupportedCurrencies();  for test
      final currencies = (await remoteDataSource.getSupportedCurrencies());

      logMessageWithPrefix(
        "Count items: ${currencies.length}",
        prefix: getCurrentMethodNameLog(),
        isGroup: true,
      );

      await localDataSource.saveSupportedCurrencies(exchangeId, currencies);
      logMessageWithPrefix(
        "Updated rows in local storage for items: ${currencies.length}",
        prefix: getCurrentMethodNameLog(),
        isGroup: true,
      );

      return currencies.map((e) => e.toEntity()).toList();
    } catch (e, stackTrace) {
      logError(e, stackTrace);

      if (!fromLocalRequest) {
        return await _getLocalSupportedCurrencies(
            exchangeId: exchangeId, fromRemoteRequest: true);
      } else {
        rethrow;
      }
    }
  }

  FutureOr<List<Currency>> _getLocalSupportedCurrencies({
    required int exchangeId,
    bool fromRemoteRequest = false,
  }) async {
    try {
      final currencies = (await localDataSource.getSupportedCurrencies())
          .map((e) => e.toEntity())
          .toList();

      logMessageWithPrefix(
        "Count items: ${currencies.length}",
        prefix: getCurrentMethodNameLog(),
        isGroup: true,
      );

      if (currencies.isEmpty) {
        throw 'Empty list from local storage';
      }

      return currencies;
    } catch (e, stackTrace) {
      logError(e, stackTrace);

      if (!fromRemoteRequest) {
        return await _getRemoteSupportedCurrencies(
            exchangeId: exchangeId, fromLocalRequest: true);
      } else {
        rethrow;
      }
    }
  }

  @override
  FutureOr<List<Exchange>> getSupportedExchanges() {
    return List.generate(
        10, (e) => Exchange(id: e + 1, title: "Exchange ${e + 1}"));
  }

  @override
  Future<List<CurrencyRate>> getExchangeRates(
      Exchange exchange, String baseCurrency) async {
    logMessageWithPrefix(
      "Loading for currency: $baseCurrency ...",
      prefix: getCurrentMethodNameLog(),
      isGroup: true,
    );

    try {
      final remoteRates = await localDataSource.getExchangeRates(
        exchangeId: exchange.id,
        baseCurrency: baseCurrency,
      );

      return remoteRates.map((e) => e.toEntity()).toList();
    } catch (e, _) {
      log("Local data is null");
    }

    try {
      final remoteRates = await remoteDataSource.getExchangeRates(
        exchangeId: exchange.id,
        baseCurrency: baseCurrency,
      );

      localDataSource.saveExchangeRates(
          exchangeId: exchange.id,
          baseCurrency: baseCurrency,
          value: remoteRates);

      return remoteRates.map((e) => e.toEntity()).toList();
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      rethrow;
    }
  }

  @override
  FutureOr<bool> addRatesToHistory({
    required Exchange exchange,
    required Currency currencyFrom,
    required Currency? currencyTo,
    required double? value,
    required List<CurrencyRate> items,
  }) async {
    logMessageWithPrefix(
      "Add rates to history for [Excange: ${exchange.id}:${exchange.title}] from \"${currencyFrom.currencyCode}\" to \"${currencyTo?.currencyCode}\", value: \"$value\": ...",
      prefix: getCurrentMethodNameLog(),
      isGroup: true,
    );

    try {
      await localDataSource.addRatesToHistory(
        exchangeId: exchange.id,
        exchangeTitle: exchange.title,
        currencyCodeFrom: currencyFrom.currencyCode,
        currencyNameFrom: currencyFrom.currencyName,
        currencyCodeTo: currencyTo?.currencyCode,
        currencyNameTo: currencyTo?.currencyName,
        value: value,
        items: items
            .map((e) => HistoryResultItemModel(
                  currencyCodeFrom: currencyFrom.currencyCode,
                  currencyNameFrom: currencyFrom.countryName,
                  currencyCodeTo: e.code,
                  currencyNameTo: e.currency?.currencyName,
                  value: e.value,
                  rate: e.rate,
                ))
            .toList(),
      );

      return true;
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      rethrow;
    }
  }

  @override
  FutureOr<List<HistoryRate>> getHistoryRates() async {
    logMessageWithPrefix(
      "Loading history: ...",
      prefix: getCurrentMethodNameLog(),
      isGroup: true,
    );

    try {
      final remoteRates = await localDataSource.getRatesHistory();
      return remoteRates.map((e) => e.toEntity()).toList();
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      rethrow;
    }
  }

  @override
  FutureOr<List<CurrencyRateByDate>> getExchangeCurrencyDetails({
    required int exchangeId,
    required String cyrrencyBase,
    required String currencyTo,
    required DateTime month,
  }) async {
    DateTime getLastDateForMonth(DateTime date) {
      DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
      DateTime now = DateTime.now();
      int day = date.isAfter(DateTime(now.year, now.month, 1)) &&
              now.day < lastDayOfMonth.day
          ? now.day
          : lastDayOfMonth.day;

      return DateTime(date.year, date.month, day);
    }

    final DateTime dateFrom = DateTime(month.year, month.month, 1);
    final DateTime dateTo = getLastDateForMonth(month);

    logMessageWithPrefix(
      "Get list of currencies from [Exchange: $exchangeId] for \"$cyrrencyBase\" to \"$currencyTo\", dateFrom: \"$dateFrom\", dateTo: \"$dateTo\": ...",
      prefix: getCurrentMethodNameLog(),
      isGroup: true,
    );

    try {
      final remoteRates = await localDataSource.getExchangeCurrencyByDate(
          exchangeId: exchangeId,
          currencyBase: cyrrencyBase,
          currencyTo: currencyTo,
          dateFrom: dateFrom,
          dateTo: dateTo);

      return remoteRates.map((e) => e.toEntity()).toList();
    } catch (e, _) {
      log("Local data is null");
    }

    try {
      final remoteRates = await remoteDataSource.getExchangeCurrencyByDate(
        exchangeId: exchangeId,
        currencyBase: cyrrencyBase,
        currencyTo: currencyTo,
        dateFrom: dateFrom,
        dateTo: dateTo,
      );

      localDataSource.saveExchangeCurrencyByDate(
          exchangeId: exchangeId,
          currencyBase: cyrrencyBase,
          currencyTo: currencyTo,
          dateFrom: dateFrom,
          dateTo: dateTo,
          value: remoteRates);

      return remoteRates.map((e) => e.toEntity()).toList();
    } catch (e, stackTrace) {
      logError(e, stackTrace);

      rethrow;
    }
  }
}
