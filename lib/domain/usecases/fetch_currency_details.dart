import 'package:currency_calculator/core/use_cases/use_case.dart';
import 'package:currency_calculator/domain/entities/currency_details/currency_rate_by_date.dart';
import 'package:currency_calculator/domain/repositories/currency_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchCurrencyDetails
    implements UseCase<List<CurrencyRateByDate>, FetchCurrencyDetailsParams> {
  final CurrencyRepository repository;

  FetchCurrencyDetails(this.repository);

  @override
  Future<List<CurrencyRateByDate>> call(
      FetchCurrencyDetailsParams params) async {
    return await repository.getExchangeCurrencyDetails(
      exchangeId: params.exchangeId,
      cyrrencyBase: params.cyrrencyBase,
      currencyTo: params.cyrrencyTo,
      month: params.month,
    );
  }
}

class FetchCurrencyDetailsParams {
  final int exchangeId;
  final String cyrrencyBase;
  final String cyrrencyTo;
  final DateTime month;

  FetchCurrencyDetailsParams({
    required this.exchangeId,
    required this.cyrrencyBase,
    required this.cyrrencyTo,
    required this.month,
  });
}
