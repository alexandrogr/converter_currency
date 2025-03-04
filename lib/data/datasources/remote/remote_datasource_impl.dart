import 'package:currency_calculator/core/network/dio_client_remote.dart';
import 'package:currency_calculator/data/datasources/abstract_datasource.dart';
import 'package:currency_calculator/data/models/currency_converter/currency_model.dart';
import 'package:currency_calculator/data/models/currency_converter/currency_rate_model.dart';
import 'package:currency_calculator/data/models/currency_details/currency_rate_by_date_model.dart';
import 'package:currency_calculator/data/models/history/history_model.dart';
import 'package:currency_calculator/data/models/history/history_result_item_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoteDataSourceImpl extends AbstractDataSource {
  final DioClientRemote client;

  RemoteDataSourceImpl(this.client);

  @override
  Future<List<CurrencyModel>> getSupportedCurrencies() async {
    final response = await client.dio.get(
      '/supported-currencies',
    );

    if (response.statusCode == 200) {
      return CurrencyModel.fromJsonItems(
              (response.data["supportedCurrenciesMap"] as Map<String, dynamic>)
                  .values
                  .toList())
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

    return [];
  }

  @override
  Future<void> addRatesToHistory(
      {required int exchangeId,
      required String? exchangeTitle,
      required String currencyCodeFrom,
      required String? currencyNameFrom,
      required String? currencyCodeTo,
      required String? currencyNameTo,
      required double? value,
      required List<HistoryResultItemModel> items}) {
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
  }) {
    // TODO: implement getExchangeCurrencyByDate
    throw UnimplementedError();
  }
}
