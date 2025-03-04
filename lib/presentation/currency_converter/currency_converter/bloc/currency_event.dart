part of 'currency_bloc.dart';

@freezed
class CurrencyEvent with _$CurrencyEvent {
  const factory CurrencyEvent.loadData(FilterStateData form) =
      _LoadCurrencyFromEvent;

  const factory CurrencyEvent.filterData(FilterStateData form) =
      _FilterCurrencyFromEvent;

  const factory CurrencyEvent.filterValue(FilterStateData form) =
      _FilterValueCurrencyFromEvent;

  const factory CurrencyEvent.saveResultWithFilter(FilterStateData form) =
      _SaveResultWithFilterCurrencyFromEvent;

  const factory CurrencyEvent.addSupportedCurrencies(
          Exchange? exchange, List<Currency> items) =
      _AddSupportedCurrenciesCurrencyFromEvent;
}
