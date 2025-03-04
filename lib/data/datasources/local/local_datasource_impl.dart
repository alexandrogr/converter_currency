import 'dart:async';

import 'package:currency_calculator/core/database/local_cache.dart';
import 'package:currency_calculator/core/database/local_database.dart';
import 'package:currency_calculator/core/helpers/date_helper.dart';
import 'package:currency_calculator/core/utils/log_mixin.dart';
import 'package:currency_calculator/data/datasources/abstract_datasource.dart';
import 'package:currency_calculator/data/models/currency_converter/currency_model.dart';
import 'package:currency_calculator/data/models/currency_converter/currency_rate_model.dart';
import 'package:currency_calculator/data/models/currency_details/currency_rate_by_date_model.dart';
import 'package:currency_calculator/data/models/history/history_model.dart';
import 'package:currency_calculator/data/models/history/history_result_item_model.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocalDataSourceImpl extends AbstractDataSource with LogMixin {
  final LocalDatabase database;
  final LocalCache cache;
  LocalDataSourceImpl(this.database, this.cache);

  Future<void> clearSupportedCurrencies() async {
    try {
      // delete all rows
      await database.managers.supportedCurrencyTable.delete();
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw Exception("Failed to save exchange rates from local base");
    }
  }

  // Save currency rates.
  Future<void> saveSupportedCurrencies(
      int exchangeId, List<CurrencyModel> items) async {
    try {
      // delete all rows
      await database.managers.supportedCurrencyTable.delete();

      // Add a bunch of default items in a batch
      await database.batch((batch) {
        // functions in a batch don't have to be awaited - just
        // await the whole batch afterwards.
        batch.insertAll(
            database.supportedCurrencyTable,
            items.map(
              (item) => SupportedCurrencyTableCompanion.insert(
                exchangeId: exchangeId,
                currencyCode: item.currencyCode,
                currencyName: Value(item.currencyName),
                countryCode: Value(item.countryCode),
                countryName: Value(item.countryName),
                createdAt: Value(DateTime.now()),
              ),
            ));
      });
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw Exception("Failed to save exchange rates from local base");
    }
  }

  @override
  Future<List<CurrencyModel>> getSupportedCurrencies() async {
    try {
      return (await database.managers.supportedCurrencyTable.get())
          .map((data) => CurrencyModel.fromDatabase(data))
          .toList();
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw Exception("Failed to load exchange rates from local base");
    }
  }

  @override
  Future<List<CurrencyRateModel>> getExchangeRates({
    required int exchangeId,
    required String baseCurrency,
  }) async {
    try {
      return cache.fromCache<List<CurrencyRateModel>>(_getExchangeRatesKey(
        exchangeId: exchangeId,
        baseCurrency: baseCurrency,
      ));
    } catch (e, _) {
      // logError(e, stackTrace);
      rethrow;
    }
  }

  String _getExchangeRatesKey({
    required int exchangeId,
    required String baseCurrency,
  }) {
    return "getExchangeRates:ex.$exchangeId:bc.$baseCurrency";
  }

  bool saveExchangeRates({
    required int exchangeId,
    required String baseCurrency,
    required List<CurrencyRateModel> value,
  }) {
    try {
      cache.addToCache<List<CurrencyRateModel>>(
          _getExchangeRatesKey(
            exchangeId: exchangeId,
            baseCurrency: baseCurrency,
          ),
          value);

      log("Saved data to local storage");
      return true;
    } catch (e, _) {
      // logError(e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> addRatesToHistory({
    required int exchangeId,
    required String? exchangeTitle,
    required String currencyCodeFrom,
    required String? currencyNameFrom,
    required String? currencyCodeTo,
    required String? currencyNameTo,
    required double? value,
    required List<HistoryResultItemModel> items,
  }) async {
    try {
      // delete all rows for test
      // await database.managers.historyTable.delete();

      await database.managers.historyTable.create((o) => o(
            exchangeId: exchangeId,
            exchangeTitle: Value(exchangeTitle),
            currencyCodeFrom: currencyCodeFrom,
            currencyNameFrom: Value(currencyNameFrom),
            currencyCodeTo: Value(currencyCodeTo),
            currencyNameTo: Value(currencyNameTo),
            value: Value(value),
            result: Value(HistoryResultItemModel.serializeList(items)),
            createdAt: Value(DateTime.now()),
          ));
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw Exception("Failed to save exchange rates from local base");
    }
  }

  @override
  Future<List<HistoryModel>> getRatesHistory({int limit = 100}) async {
    try {
      return (await (database.select(database.historyTable)
                // ..where((t) => t.id.equals(id))
                ..orderBy([
                  (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)
                ])
                ..limit(limit))
              .get())
          .map((data) => HistoryModel.fromDatabase(data))
          .toList();
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw Exception("Failed to load exchange rates from local base");
    }
  }

  @override
  FutureOr<List<CurrencyRateByDateModel>> getExchangeCurrencyByDate({
    required int exchangeId,
    required String currencyBase,
    required String currencyTo,
    required DateTime dateFrom,
    required DateTime dateTo,
  }) {
    try {
      return cache.fromCache<List<CurrencyRateByDateModel>>(
          _getExchangeCurrencyByDateKey(
              exchangeId: exchangeId,
              currencyBase: currencyBase,
              currencyTo: currencyTo,
              dateFrom: dateFrom,
              dateTo: dateTo));
    } catch (e, _) {
      // logError(e, stackTrace);
      rethrow;
    }
  }

  String _getExchangeCurrencyByDateKey({
    required int exchangeId,
    required String currencyBase,
    required String currencyTo,
    required DateTime dateFrom,
    required DateTime dateTo,
  }) {
    return "getExchangeCurrencyByDate:ex.$exchangeId:cb.$currencyBase:ct.$currencyTo:df.${DateHelper.formatDate(dateFrom)}:dt.${DateHelper.formatDate(dateTo)}";
  }

  bool saveExchangeCurrencyByDate({
    required int exchangeId,
    required String currencyBase,
    required String currencyTo,
    required DateTime dateFrom,
    required DateTime dateTo,
    required List<CurrencyRateByDateModel> value,
  }) {
    try {
      cache.addToCache<List<CurrencyRateByDateModel>>(
          _getExchangeCurrencyByDateKey(
              exchangeId: exchangeId,
              currencyBase: currencyBase,
              currencyTo: currencyTo,
              dateFrom: dateFrom,
              dateTo: dateTo),
          value);

      log("Saved data to local storage");

      return true;
    } catch (e, _) {
      // logError(e, stackTrace);
      rethrow;
    }
  }
}
