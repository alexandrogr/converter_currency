part of 'history_cubit.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState.initial() = _InitialHistoryState;

  const factory HistoryState.loading() = _LoadingHistoryState;
  const factory HistoryState.loaded(List<HistoryListItemStateData> items) =
      _LoadedHistoryState;
  const factory HistoryState.error(String error) = _ErrorHistoryState;
  const factory HistoryState.empty() = _EmptyHistoryState;
}
