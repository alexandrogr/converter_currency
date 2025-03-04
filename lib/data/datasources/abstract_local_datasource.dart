import 'dart:async';

import 'package:currency_calculator/data/datasources/abstract_remote_datasource.dart';
import 'package:currency_calculator/data/models/history/history_model.dart';
import 'package:currency_calculator/data/models/history/history_result_item_model.dart';

abstract class AbstractLocalDataSource extends AbstractRemoteDataSource {
  Future<void> addRatesToHistory({
    required int exchangeId,
    required String? exchangeTitle,
    required String currencyCodeFrom,
    required String? currencyNameFrom,
    required String? currencyCodeTo,
    required String? currencyNameTo,
    required double? value,
    required List<HistoryResultItemModel> items,
  });
  Future<List<HistoryModel>> getRatesHistory({int limit = 100});
}
