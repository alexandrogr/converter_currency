import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:currency_calculator/domain/entities/exchange/exchange.dart';
import 'package:currency_calculator/presentation/currency_converter/filter/data/filter_state_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_currency_cubit.freezed.dart';
part 'filter_currency_state.dart';

class FilterCurrencyCubit extends Cubit<FilterCurrencyState> {
  FilterCurrencyCubit()
      : super(
            FilterCurrencyState.changed(FilterStateData(), FilterStateData()));

  Future<void> changeCurrencyFrom(Currency? currency) async {
    emit(FilterCurrencyState.changed(
        state.form.copyWith(fromCurrency: currency), state.form));
  }

  Future<void> changeCurrencyTo(Currency? currency) async {
    emit(FilterCurrencyState.changed(
        state.form.copyWith(toCurrency: currency), state.form));
  }

  Future<void> changeValue(double? value) async {
    emit(FilterCurrencyState.changed(
        state.form.copyWith(value: value), state.form));
  }

  Future<void> clear() async {
    emit(FilterCurrencyState.changed(
        FilterStateData(exchange: state.form.exchange), state.form));
  }

  Future<void> setExchange(Exchange? exchange) async {
    emit(FilterCurrencyState.changed(
        FilterStateData(exchange: exchange), state.form));
  }
}
