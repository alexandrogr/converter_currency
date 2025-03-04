import 'package:bloc/bloc.dart';
import 'package:currency_calculator/core/use_cases/use_case.dart';
import 'package:currency_calculator/core/utils/log_mixin.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:currency_calculator/domain/entities/exchange/exchange.dart';
import 'package:currency_calculator/domain/usecases/settings/fetch_supported_currencies.dart';
import 'package:currency_calculator/domain/usecases/settings/fetch_supported_exchanges.dart';
import 'package:currency_calculator/presentation/currency_converter/settings/data/settings_state_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_cubit.freezed.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> with LogMixin {
  final FetchSupportedCurrencies fetchSupportedCurrencies;
  final FetchSupportedeEchange fetchSupportedeEchange;

  SettingsCubit(this.fetchSupportedCurrencies, this.fetchSupportedeEchange)
      : super(SettingsState.initial(SettingsStateData())) {
    _loadData();
  }

  final List<Exchange> excahnges = [];

  Future<void> _loadData() async {
    SettingsStateData form = state.form.copyWith();

    emit(SettingsState.loading(form, true));

    try {
      final exchanges = await _loadSupportedExchange();

      if (exchanges.isEmpty) {
        throw Exception("List of exchanges is null");
      }

      form = form.copyWith(
        excahnges: exchanges,
        selectedExcahnge: exchanges.first,
      );

      final currencies = await _loadSupportedCurrencies(exchanges.first);
      emit(SettingsState.loaded(form.copyWith(currencies: currencies)));
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      emit(SettingsState.error(form, 'Failed to load requred data'));
    }
  }

  Future<List<Currency>> _loadSupportedCurrencies(Exchange excahnge) async {
    try {
      final List<Currency> items = await fetchSupportedCurrencies(
          FetchSupportedCurrenciesParams(exchange: excahnge));

      if (items.isNotEmpty) {
        return items;
      } else {
        throw Exception("List of currencies is null");
      }
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      rethrow;
    }
  }

  Future<List<Exchange>> _loadSupportedExchange() async {
    try {
      final List<Exchange> items = await fetchSupportedeEchange(NoParams());

      if (items.isNotEmpty) {
        return items;
      } else {
        throw Exception("List of currencies is null");
      }
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      rethrow;
    }
  }

  Future<void> changeExchange(Exchange exchange) async {
    log("Changed exchange to $exchange");

    SettingsStateData form = state.form.copyWith(
      selectedExcahnge: exchange,
    );
    emit(SettingsState.loading(form, false));

    try {
      final currencies = await _loadSupportedCurrencies(exchange);
      emit(SettingsState.loaded(form.copyWith(currencies: currencies)));
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      emit(SettingsState.error(form, 'Failed to load requred data'));
    }
  }
}
