import 'package:currency_calculator/domain/entities/history/history_rate.dart';

abstract class HistoryListItemStateData {}

class HistoryListItemStateModelData extends HistoryListItemStateData {
  HistoryRate model;
  HistoryListItemStateModelData({
    required this.model,
  });
}

class HistoryListItemStateTitleData extends HistoryListItemStateData {
  DateTime date;
  HistoryListItemStateTitleData({
    required this.date,
  });
}
