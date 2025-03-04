part of 'currency_bloc.dart';

@freezed
class CurrencyState with _$CurrencyState {
  const CurrencyState._();
  const factory CurrencyState.changed(FilterStateData form) =
      _ChangedCurrencyState;
  const factory CurrencyState.loading(FilterStateData form) =
      _LoadingCurrencyState;
  const factory CurrencyState.loaded(
      FilterStateData form, List<CurrencyRate> items) = _LoadedCurrencyState;
  const factory CurrencyState.error(FilterStateData form, String error) =
      _ErrorCurrencyState;
  const factory CurrencyState.empty(FilterStateData form) = _EmptyCurrencyState;

  // List<CurrencyRate> filteredItems(FilterStateData? form) {
  //   return maybeWhen(
  //     orElse: () => [],
  //     loaded: (form, items) => form != null ? items : items,
  //   );
  // }
}
