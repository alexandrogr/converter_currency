import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_result_item_model.freezed.dart';
part 'history_result_item_model.g.dart';

@freezed
class HistoryResultItemModel with _$HistoryResultItemModel {
  HistoryResultItemModel._();
  factory HistoryResultItemModel({
    String? currencyCodeFrom,
    String? currencyNameFrom,
    String? currencyCodeTo,
    String? currencyNameTo,
    double? rate,
    double? value,
  }) = _HistoryResultItemModel;

  factory HistoryResultItemModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryResultItemModelFromJson(json);

  // Helper to convert List<CustomClass> to a blob and back
  static Uint8List serializeList(List<HistoryResultItemModel> list) {
    final jsonList = list.map((e) => e.toJson()).toList();
    return utf8.encode(jsonEncode(jsonList));
  }

  static List<HistoryResultItemModel> deserializeList(List<int> blob) {
    final jsonList = jsonDecode(utf8.decode(blob)) as List;
    return jsonList
        .map((json) =>
            HistoryResultItemModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
