import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:currency_calculator/core/utils/log_mixin.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency_rate.dart';
import 'package:currency_calculator/domain/entities/exchange/exchange.dart';
import 'package:currency_calculator/domain/usecases/fetch_currencies_by_filter.dart';
import 'package:currency_calculator/domain/usecases/history/save_history_rates.dart';
import 'package:currency_calculator/presentation/currency_converter/filter/data/filter_state_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stream_transform/stream_transform.dart';

part 'currency_bloc.freezed.dart';
part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> with LogMixin {
  final FetchCurrenciesByFilter fetchCurrenciesByFilter;
  final SaveHistoryRates saveHistoryRates;

  List<Currency> supportedCurrencies = [];
  List<CurrencyRate> items = []; // maybe for paginations or failure from server

  CurrencyBloc(this.fetchCurrenciesByFilter, this.saveHistoryRates)
      : super(CurrencyState.changed(FilterStateData())) {
    on<_AddSupportedCurrenciesCurrencyFromEvent>((event, emit) async {
      items.clear();
      supportedCurrencies = event.items;

      emit(CurrencyState.changed(FilterStateData(
        exchange: event.exchange,
      )));
    });

    on<_LoadCurrencyFromEvent>(
      (event, emit) async {
        if (!event.form.isSelectedBaseCurrency) {
          return;
        }

        final form = event.form.copyWith();
        emit(CurrencyState.loading(form));

        try {
          items = (await fetchCurrenciesByFilter(FetchCurrenciesByFilterParams(
                  exchange: form.exchange!, cyrrencyBase: form.fromCurrency!)))
              .map((element) {
            if (supportedCurrencies
                .where((e) =>
                    e.currencyCode.toUpperCase() == element.code.toUpperCase())
                .isNotEmpty) {
              return element.copyWith(
                  currency: supportedCurrencies.firstWhere((e) =>
                      e.currencyCode.toUpperCase() ==
                      element.code.toUpperCase()));
            }

            return element;
          }).toList();

          if (items.isEmpty) {
            emit(CurrencyState.empty(form));
          } else {
            emit(CurrencyState.loaded(form, items));
            add(CurrencyEvent.filterData(form));
          }
        } catch (e, stackTrace) {
          logError(e, stackTrace);
          emit(CurrencyState.error(form, 'Failed to load currencies'));
        }
      },
      transformer: restartable(),
    );

    on<_FilterCurrencyFromEvent>(
      (event, emit) async {
        if (state is _LoadedCurrencyState) {
          emit(CurrencyState.loaded(
              event.form.copyWith(), _getFilteredList(event.form.copyWith())));
          add(CurrencyEvent.saveResultWithFilter(event.form.copyWith()));
        }
      },
    );

    on<_FilterValueCurrencyFromEvent>(
      (event, emit) async {
        if (state is _LoadedCurrencyState) {
          emit(CurrencyState.loaded(
              event.form.copyWith(), _getFilteredList(event.form.copyWith())));
          add(CurrencyEvent.saveResultWithFilter(event.form.copyWith()));
        }
      },
      transformer: debounce(duration: Duration(milliseconds: 300)),
    );

    on<_SaveResultWithFilterCurrencyFromEvent>(
      (event, emit) async {
        if (!event.form.isFilled && event.form.exchange != null) {
          return;
        }

        try {
          await saveHistoryRates(SaveHistoryRatesParams(
            exchange: event.form.exchange!,
            currencyFrom: event.form.fromCurrency!,
            currencyTo: event.form.toCurrency,
            value: event.form.value,
            items: _getFilteredList(event.form),
          ));
        } catch (e) {
          // ignore
        }
      },
      transformer: debounce(duration: Duration(milliseconds: 300)),
    );
  }

  List<CurrencyRate> _getFilteredList(FilterStateData form) {
    List<CurrencyRate> filteredItems = [...items];

    if (form.isSelectedConvertedCurrency) {
      filteredItems = filteredItems
          .where((e) =>
              e.code.toUpperCase() ==
              form.toCurrency!.currencyCode.toUpperCase())
          .toList();
    }

    if (form.hasValue) {
      filteredItems =
          filteredItems.map((e) => e.copyWith(value: form.value ?? 1)).toList();
    }

    return filteredItems;
  }
}

/// Custom debounce transformer for BLoC
EventTransformer<Event> debounce<Event>({
  Duration duration = const Duration(milliseconds: 300),
}) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}
