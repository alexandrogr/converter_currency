part of 'filter_currency_cubit.dart';

@freezed
class FilterCurrencyState with _$FilterCurrencyState {
  const factory FilterCurrencyState.changed(
          FilterStateData form, FilterStateData oldForm) =
      _InitialFilterCurrencyState;
}
