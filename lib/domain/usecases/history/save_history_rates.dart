import 'package:currency_calculator/core/use_cases/use_case.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency_rate.dart';
import 'package:currency_calculator/domain/entities/exchange/exchange.dart';
import 'package:currency_calculator/domain/repositories/currency_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveHistoryRates implements UseCase<bool, SaveHistoryRatesParams> {
  final CurrencyRepository repository;

  SaveHistoryRates(this.repository);

  @override
  Future<bool> call(SaveHistoryRatesParams params) async {
    return await repository.addRatesToHistory(
      exchange: params.exchange,
      currencyFrom: params.currencyFrom,
      currencyTo: params.currencyTo,
      value: params.value,
      items: params.items,
    );
  }
}

class SaveHistoryRatesParams {
  final Exchange exchange;
  final Currency currencyFrom;
  final Currency? currencyTo;
  final double? value;
  final List<CurrencyRate> items;

  SaveHistoryRatesParams({
    required this.exchange,
    required this.currencyFrom,
    required this.currencyTo,
    required this.value,
    required this.items,
  });
}
