import 'dart:convert';
import 'dart:math';

import 'package:currency_calculator/core/constants/constants.dart';
import 'package:currency_calculator/core/network/dio_client_remote.dart';
import 'package:currency_calculator/data/datasources/abstract_datasource.dart';
import 'package:currency_calculator/data/models/currency_converter/currency_model.dart';
import 'package:currency_calculator/data/models/currency_converter/currency_rate_model.dart';
import 'package:currency_calculator/data/models/currency_details/currency_rate_by_date_model.dart';
import 'package:currency_calculator/data/models/history/history_model.dart';
import 'package:currency_calculator/data/models/history/history_result_item_model.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoteDataSourceDemo extends AbstractDataSource {
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

//   {
//   "date": "2023-03-21 12:43:00+00",
//   "base": "USD",
//   "rates": {
//     "AGLD": "2.3263929277654998",
//     "FJD": "2.21592",
//     "MXN": "18.670707655673546",
//     "LVL": "0.651918",
//     "SCR": "13.21713243157135",
//     "CDF": "2068.490771",
//     "BBD": "2.0",
//     "HNL": "24.57644632001569",
//     .
//     .
//     .
//   }
// }

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

    // final response = await client.dio.get(
    //   '${ApiConstants.baseUrl}/latest',
    //   queryParameters: {
    //     'base_currency': baseCurrency,
    //     'apikey': ApiConstants.apiKey,
    //   },
    // );

    // if (response.statusCode == 200) {
    //   List<dynamic> rates = response.data['data'];
    //   return rates.map((rateData) => CurrencyModel.fromJson(rateData)).toList();
    // } else {
    //   throw Exception("Failed to load exchange rates");
    // }
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
  }) {
    // TODO: implement addRatesToHistory
    throw UnimplementedError();
  }

  @override
  Future<List<HistoryModel>> getRatesHistory({int limit = 100}) {
    // TODO: implement getRatesHistory
    throw UnimplementedError();
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
