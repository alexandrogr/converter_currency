import 'package:bloc/bloc.dart';
import 'package:currency_calculator/core/use_cases/use_case.dart';
import 'package:currency_calculator/core/utils/log_mixin.dart';
import 'package:currency_calculator/domain/entities/history/history_rate.dart';
import 'package:currency_calculator/domain/usecases/history/fetch_history_rates.dart';
import 'package:currency_calculator/presentation/history/data/history_list_item_state_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_cubit.freezed.dart';
part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> with LogMixin {
  final FetchHistoryRates fetchHistoryRates;

  HistoryCubit(this.fetchHistoryRates) : super(HistoryState.initial()) {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    emit(HistoryState.loading());
    try {
      final items = await fetchHistoryRates(NoParams());

      if (items.isNotEmpty) {
        DateTime? prevDate;
        List<HistoryListItemStateData> newItems = [];

        for (HistoryRate item in items) {
          DateTime? date = item.createdAt != null
              ? DateTime(item.createdAt!.year, item.createdAt!.month,
                  item.createdAt!.day)
              : null;

          if (date != null && (prevDate == null || prevDate != date)) {
            prevDate = date;
            newItems.add(HistoryListItemStateTitleData(date: date));
          }

          newItems.add(HistoryListItemStateModelData(model: item));
        }

        emit(HistoryState.loaded(newItems));
      } else {
        throw Exception("List of items is null");
      }
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      emit(HistoryState.error('Failed to load items'));
    }
  }
}
