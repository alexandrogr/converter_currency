import 'package:currency_calculator/core/constants/app_constants.dart';
import 'package:currency_calculator/core/helpers/date_helper.dart';
import 'package:currency_calculator/core/network/dio_client_remote.dart';
import 'package:currency_calculator/data/datasources/abstract_remote_datasource.dart';
import 'package:currency_calculator/data/models/currency_converter/currency_model.dart';
import 'package:currency_calculator/data/models/currency_converter/currency_rate_model.dart';
import 'package:currency_calculator/data/models/currency_details/currency_rate_by_date_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoteDataSourceImpl extends AbstractRemoteDataSource {
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
    final response = await client.dio.get(
      '${ApiConstants.baseUrl}/latest',
      queryParameters: {
        'base_currency': baseCurrency,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> rates = response.data['data'];
      return rates
          .map((rateData) => CurrencyRateModel.fromJson(rateData))
          .toList();
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
    final response = await client.dio.get(
      '${ApiConstants.baseUrl}/details',
      queryParameters: {
        'currency_from': currencyBase,
        'currency_to': currencyTo,
        'date_from': DateHelper.systemFormat(dateFrom),
        'date_to': DateHelper.systemFormat(dateTo),
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> rates = response.data['data'];
      return rates
          .map((rateData) => CurrencyRateByDateModel.fromJson(rateData))
          .toList();
    } else {
      throw Exception("Failed to load exchange rates");
    }
  }
}
