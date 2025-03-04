part of 'currency_details_cubit.dart';

@freezed
class CurrencyDetailsState with _$CurrencyDetailsState {
  const CurrencyDetailsState._();
  const factory CurrencyDetailsState.initial(CurrencyDetailsStateData form) =
      _InitialCurrencyDetailsState;
  const factory CurrencyDetailsState.loading(CurrencyDetailsStateData form) =
      _LoadingCurrencyDetailsState;
  const factory CurrencyDetailsState.loaded(
          CurrencyDetailsStateData form, List<CurrencyRateByDate> items) =
      _LoadedCurrencyDetailsState;
  const factory CurrencyDetailsState.error(
      CurrencyDetailsStateData form, String error) = _ErrorCurrencyDetailsState;

  List<CurrencyRateByDate> get actualItems => maybeWhen(
        loaded: (form, items) => items,
        orElse: () => [],
      );

  Map<String, double> itemsToMapByDates(List<CurrencyRateByDate> items) =>
      {for (var item in items) DateHelper.systemFormat(item.date): item.value};

  bool get isLoading => maybeWhen(
        loading: (_) => true,
        orElse: () => false,
      );
}
