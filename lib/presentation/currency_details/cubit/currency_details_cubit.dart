import 'package:bloc/bloc.dart';
import 'package:currency_calculator/core/helpers/date_helper.dart';
import 'package:currency_calculator/core/utils/log_mixin.dart';
import 'package:currency_calculator/domain/entities/currency_details/currency_rate_by_date.dart';
import 'package:currency_calculator/domain/usecases/fetch_currency_details.dart';
import 'package:currency_calculator/presentation/currency_details/data/currency_details_state_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_details_cubit.freezed.dart';
part 'currency_details_state.dart';

class CurrencyDetailsCubit extends Cubit<CurrencyDetailsState> with LogMixin {
  final FetchCurrencyDetails fetchCurrencyDetails;
  final int exchangeId;
  final String codeBase;
  final String codeTo;

  CurrencyDetailsCubit(
    this.fetchCurrencyDetails, {
    required this.exchangeId,
    required this.codeBase,
    required this.codeTo,
  }) : super(CurrencyDetailsState.initial(
            CurrencyDetailsStateData.forCurrentMonth(
          exchangeId: exchangeId,
          currencyCodeBase: codeBase,
          currencyCodeTo: codeTo,
        ))) {
    _loadData(state.form.copyWith());
  }

  Future<void> _loadData(CurrencyDetailsStateData form) async {
    emit(CurrencyDetailsState.loading(form));
    try {
      final currencies = await fetchCurrencyDetails(FetchCurrencyDetailsParams(
        exchangeId: form.exchangeId,
        cyrrencyBase: form.currencyCodeBase,
        cyrrencyTo: form.currencyCodeTo,
        month: form.month,
      ));

      if (currencies.isNotEmpty) {
        emit(CurrencyDetailsState.loaded(form, currencies));
      } else {
        throw Exception("List of currencies is null");
      }
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      emit(CurrencyDetailsState.error(form, 'Failed to load currencies'));
    }
  }

  // change to loading last 3 month

  Future<void> changeToNextMonth() async {
    if (state.form.hasNextMonth) {
      _loadData(state.form.forNextMonth());
    }
  }

  Future<void> changeToPrevMonth() async {
    _loadData(state.form.forPrevMonth());
  }

  Future<void> changeMonth(DateTime month) async {
    _loadData(state.form.copyWith(month: DateTime(month.year, month.month, 1)));
  }
}
