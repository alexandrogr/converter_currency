import 'package:currency_calculator/core/use_cases/use_case.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency_rate.dart';
import 'package:currency_calculator/domain/entities/exchange/exchange.dart';
import 'package:currency_calculator/domain/repositories/currency_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchCurrenciesByFilter
    implements UseCase<List<CurrencyRate>, FetchCurrenciesByFilterParams> {
  final CurrencyRepository repository;

  FetchCurrenciesByFilter(this.repository);

  @override
  Future<List<CurrencyRate>> call(FetchCurrenciesByFilterParams params) async {
    return await repository.getExchangeRates(
        params.exchange, params.cyrrencyBase.currencyCode);
  }
}

class FetchCurrenciesByFilterParams {
  final Exchange exchange;
  final Currency cyrrencyBase;
  FetchCurrenciesByFilterParams({
    required this.exchange,
    required this.cyrrencyBase,
  });
}
