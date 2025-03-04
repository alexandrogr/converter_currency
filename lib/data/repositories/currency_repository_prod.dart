import 'dart:async';

import 'package:currency_calculator/core/network/data_priority.dart';
import 'package:currency_calculator/core/utils/log_mixin.dart';
import 'package:currency_calculator/data/datasources/local/local_datasource_impl.dart';
import 'package:currency_calculator/data/datasources/remote/remote_datasource_impl.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency_rate.dart';
import 'package:currency_calculator/domain/entities/currency_details/currency_rate_by_date.dart';
import 'package:currency_calculator/domain/entities/exchange/exchange.dart';
import 'package:currency_calculator/domain/entities/history/history_rate.dart';
import 'package:currency_calculator/domain/repositories/currency_repository.dart';
import 'package:currency_calculator/injectable.dart';
import 'package:injectable/injectable.dart';

// if need change to dev/prod
@Injectable(as: CurrencyRepository, env: [Env.prod])
class CurrencyRepositoryProd with LogMixin implements CurrencyRepository {
  final RemoteDataSourceImpl remoteDataSource;
  final LocalDataSourceImpl localDataSource;

  CurrencyRepositoryProd(this.remoteDataSource, this.localDataSource);

  @override
  DataPriority get defaultPrority => DataPriority.remote;

  @override
  Future<List<CurrencyRate>> getExchangeRates(
      Exchange exchange, String baseCurrency) async {
    try {
      final remoteRates = await remoteDataSource.getExchangeRates(
          exchangeId: exchange.id, baseCurrency: baseCurrency);
      // await localDataSource.saveExchangeRates(remoteRates);
      return remoteRates.map((e) => e.toEntity()).toList();
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      // return localDataSource
      //     .getExchangeRates()
      //     .map((e) => e.toEntity())
      //     .toList();

      return [];
    }
  }

  @override
  FutureOr<List<Currency>> getSupportedCurrencies({
    required int exchangeId,
  }) async {
    // if (defaultPrority == DataPriority.remote) {
    //   return await _getRemoteSupportedCurrencies();
    // } else {
    //   return await _getLocalSupportedCurrencies();
    // }

    // for this fun local in priority
    return await _getLocalSupportedCurrencies();
  }

  FutureOr<List<Currency>> _getRemoteSupportedCurrencies() async {
    // try {
    //   final currencies = await remoteDataSource.getSupportedCurrencies();
    //   await localDataSource.saveSupportedCurrencies(currencies);
    //   return currencies.map((e) => e.toEntity()).toList();
    // } catch (e, stackTrace) {
    //   logError(e, stackTrace);

    //   return (await localDataSource.getSupportedCurrencies())
    //       .map((e) => e.toEntity())
    //       .toList();
    // }

    // TODO: implement getSupportedExchanges
    throw UnimplementedError();
  }

  FutureOr<List<Currency>> _getLocalSupportedCurrencies() async {
    // try {
    //   // load without delay from server
    //   final currencies = (await localDataSource.getSupportedCurrencies())
    //       .map((e) => e.toEntity())
    //       .toList();

    //   if (currencies.isEmpty) {
    //     throw 'Empty list from local storage';
    //   }

    //   return currencies;
    // } catch (e, stackTrace) {
    //   logError(e, stackTrace);
    //   return _getRemoteSupportedCurrencies();
    // }

    // TODO: implement getSupportedExchanges
    throw UnimplementedError();
  }

  @override
  FutureOr<List<Exchange>> getSupportedExchanges() {
    // TODO: implement getSupportedExchanges
    throw UnimplementedError();
  }

  @override
  FutureOr<bool> addRatesToHistory({
    required Exchange exchange,
    required Currency currencyFrom,
    required Currency? currencyTo,
    required double? value,
    required List<CurrencyRate> items,
  }) {
    // TODO: implement addRatesToHistory
    throw UnimplementedError();
  }

  @override
  FutureOr<List<HistoryRate>> getHistoryRates() {
    // TODO: implement getHistory
    throw UnimplementedError();
  }

  @override
  FutureOr<List<CurrencyRateByDate>> getExchangeCurrencyDetails({
    required int exchangeId,
    required String cyrrencyBase,
    required String currencyTo,
    required DateTime month,
  }) {
    // TODO: implement getExchangeCurrencyDetails
    throw UnimplementedError();
  }
}
