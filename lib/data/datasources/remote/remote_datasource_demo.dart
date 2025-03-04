import 'dart:convert';
import 'dart:math';

import 'package:currency_calculator/core/constants/constants.dart';
import 'package:currency_calculator/core/network/dio_client_remote.dart';
import 'package:currency_calculator/data/datasources/abstract_remote_datasource.dart';
import 'package:currency_calculator/data/models/currency_converter/currency_model.dart';
import 'package:currency_calculator/data/models/currency_converter/currency_rate_model.dart';
import 'package:currency_calculator/data/models/currency_details/currency_rate_by_date_model.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoteDataSourceDemo extends AbstractRemoteDataSource {
  final DioClientRemote client;
  RemoteDataSourceDemo(this.client);

  int _requestCounter = 0;

  Future<List<dynamic>> loadListJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }

  Future<Map<String, dynamic>> loadMapJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }

  Future<void> _emulateInternetRequest({
    bool emulateFaild = true,
  }) async {
    if (emulateFaild) {
      _requestCounter += 1;

      if (_requestCounter == DemoConstants.countSuccessfulAttempts) {
        _requestCounter = 0;

        throw Exception("Failed to load data (emulate)");
      }
    }

    await Future.delayed(
        Duration(milliseconds: DemoConstants.requestDelayMilliseconds), () {});
  }

  @override
  Future<List<CurrencyModel>> getSupportedCurrencies() async {
    await _emulateInternetRequest();

    List<dynamic> response =
        await loadListJsonFromAssets(DemoConstants.filePath);

    if (response.isNotEmpty) {
      return CurrencyModel.fromJsonItems(response.map((element) {
        if (element is Map) {
          element["status"] = "AVAILABLE";
        }

        return element;
      }).toList())
          .where((item) => item.isAvailable && item.currencyName != null)
          .toList();
    } else {
      throw Exception("Failed to load exchange rates");
    }
  }

  @override
  Future<List<CurrencyRateModel>> getExchangeRates({
    required int exchangeId,
    required String baseCurrency,
  }) async {
    await _emulateInternetRequest();

    List<dynamic> response =
        (await loadListJsonFromAssets(DemoConstants.filePath)).where((element) {
      if (element is Map) {
        return !((element["currencyCode"] as String).toLowerCase() ==
            baseCurrency.toLowerCase());
      }

      return true;
    }).toList();

    if (response.isNotEmpty) {
      final random = Random();
      final items = response
          .map((element) => CurrencyRateModel(
                code: element["currencyCode"],
                name: element["countryName"],
                rate: random.nextDouble() * 10.0,
              ))
          .toList();

      return items;
    } else {
      throw Exception("Failed to load exchange rates");
    }
  }

  @override
  Future<List<CurrencyRateByDateModel>> getExchangeCurrencyByDate({
    required int exchangeId,
    required String currencyBase,
    required String currencyTo,
    required DateTime dateFrom,
    required DateTime dateTo,
  }) async {
    await _emulateInternetRequest(emulateFaild: false);

    if (dateTo.isAfter(dateFrom) &&
        dateTo.year == dateFrom.year &&
        dateTo.month == dateFrom.month) {
      final random = Random();

      Iterable<CurrencyRateByDateModel> generateItems(
          DateTime dateFrom, DateTime dateTo) sync* {
        for (var i = 0; i < dateTo.day; i++) {
          yield CurrencyRateByDateModel(
            currencyCodeFrom: currencyBase,
            currencyCodeTo: currencyTo,
            value: random.nextDouble() * 10.0,
            date: dateFrom.add(Duration(days: i)),
          );
        }
      }

      return generateItems(dateFrom, dateTo).toList();
    } else {
      throw Exception("Failed to load exchange rates");
    }
  }
}
