import 'package:currency_calculator/core/ui/main_title_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarCustomHeaderLine extends StatelessWidget {
  const CalendarCustomHeaderLine({
    super.key,
    required this.nowDate,
    required this.focusedDay,
    required this.onChangedMonth,
    required this.isLoadingData,
  });

  final DateTime nowDate;
  final DateTime focusedDay;
  final Function(DateTime month) onChangedMonth;
  final bool isLoadingData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left Chevron (Previous Month)
        IconButton(
          icon: Icon(
            Icons.chevron_left,
            // color: AppTheme.primaryColor,
          ),
          onPressed: isLoadingData
              ? null
              : () {
                  onChangedMonth(DateTime(
                      focusedDay.year, focusedDay.month - 1, focusedDay.day));
                },
        ),
        // Month & Year in Center
        MainTitleHeader(
          title: DateFormat.yMMMM().format(focusedDay),
        ),
        // Right Chevron (Next Month)

        DateTime(focusedDay.year, focusedDay.month + 1, focusedDay.day)
                .isBefore(nowDate)
            ? IconButton(
                icon: Icon(
                  Icons.chevron_right,
                  // color: AppTheme.primaryColor,
                ),
                onPressed: isLoadingData
                    ? null
                    : () {
                        onChangedMonth(DateTime(focusedDay.year,
                            focusedDay.month + 1, focusedDay.day));
                      },
              )
            : const SizedBox(
                width: 48.0,
              ),
      ],
    );
  }
}
