import 'package:currency_calculator/core/helpers/date_helper.dart';
import 'package:currency_calculator/core/ui/main_title_header.dart';
import 'package:flutter/material.dart';

class HistoryTitleListItem extends StatelessWidget {
  const HistoryTitleListItem({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Center(
        child: MainTitleHeader(title: DateHelper.formatDateWithoutTime(date)),
      ),
    );
  }
}
