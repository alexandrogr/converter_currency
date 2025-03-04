import 'package:currency_calculator/core/use_cases/use_case.dart';
import 'package:currency_calculator/domain/entities/exchange/exchange.dart';
import 'package:currency_calculator/domain/repositories/currency_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchSupportedeEchange implements UseCase<List<Exchange>, NoParams> {
  final CurrencyRepository repository;

  FetchSupportedeEchange(this.repository);

  @override
  Future<List<Exchange>> call(NoParams params) async {
    return await repository.getSupportedExchanges();
  }
}
