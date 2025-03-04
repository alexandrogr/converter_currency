import 'package:currency_calculator/core/use_cases/use_case.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:currency_calculator/domain/entities/exchange/exchange.dart';
import 'package:currency_calculator/domain/repositories/currency_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchSupportedCurrencies
    implements UseCase<List<Currency>, FetchSupportedCurrenciesParams> {
  final CurrencyRepository repository;

  FetchSupportedCurrencies(this.repository);

  @override
  Future<List<Currency>> call(FetchSupportedCurrenciesParams params) async {
    return await repository.getSupportedCurrencies(
      exchangeId: params.exchange.id,
    );
  }
}

class FetchSupportedCurrenciesParams {
  final Exchange exchange;
  FetchSupportedCurrenciesParams({
    required this.exchange,
  });
}
