import 'package:currency_calculator/core/use_cases/use_case.dart';
import 'package:currency_calculator/domain/entities/history/history_rate.dart';
import 'package:currency_calculator/domain/repositories/currency_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchHistoryRates implements UseCase<List<HistoryRate>, NoParams> {
  final CurrencyRepository repository;

  FetchHistoryRates(this.repository);

  @override
  Future<List<HistoryRate>> call(NoParams params) async {
    return await repository.getHistoryRates();
  }
}
