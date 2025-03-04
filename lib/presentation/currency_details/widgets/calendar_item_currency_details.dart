import 'package:currency_calculator/core/helpers/date_helper.dart';
import 'package:currency_calculator/core/helpers/number_helper.dart';
import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CalendarItemCurrencyDetails extends StatelessWidget {
  const CalendarItemCurrencyDetails({
    super.key,
    required this.itemsByDates,
    required this.day,
    this.isSelected = false,
  });

  final Map<String, double> itemsByDates;
  final DateTime day;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final dayFormatted = DateHelper.systemFormat(day);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: !isSelected ? Colors.transparent : AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${day.day}',
                style: TextStyle(
                    fontSize: 10,
                    color: isSelected ? Colors.white : Colors.grey),
              ),
              Text(
                itemsByDates.keys.contains(dayFormatted)
                    ? NumberHelper.numberFormat(itemsByDates[dayFormatted])
                    : '0.0',
                style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.white : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
