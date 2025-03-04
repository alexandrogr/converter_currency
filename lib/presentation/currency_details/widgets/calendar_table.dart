import 'package:currency_calculator/presentation/currency_details/widgets/calendar_custom_header_line.dart';
import 'package:currency_calculator/presentation/currency_details/widgets/calendar_item_currency_details.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTable extends StatelessWidget {
  const CalendarTable({
    super.key,
    required this.nowDate,
    required this.focusedDay,
    required this.selectedDay,
    required this.isLoadingData,
    required this.itemsByDates,
    required this.onChangedMonth,
    required this.onSelectedDay,
  });

  final DateTime nowDate;
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final bool isLoadingData;
  final Map<String, double> itemsByDates;
  final Function(DateTime month) onChangedMonth;
  final Function(DateTime? selectedDay, DateTime focusedDay) onSelectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarCustomHeaderLine(
          nowDate: nowDate,
          focusedDay: focusedDay,
          isLoadingData: isLoadingData,
          onChangedMonth: onChangedMonth,
        ),
        TableCalendar(
          firstDay: DateTime.utc(2010, 1, 1),
          lastDay: nowDate,
          focusedDay: focusedDay,
          // currentDay: _currentDate,
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            if (!isLoadingData) {
              onSelectedDay.call(
                  this.selectedDay == selectedDay ? null : selectedDay,
                  focusedDay);
            }
          },
          pageJumpingEnabled: !isLoadingData,
          availableGestures: isLoadingData
              ? AvailableGestures.none
              : AvailableGestures.all, // Disable gestures

          headerStyle: HeaderStyle(
            titleCentered: true, // Centers the month name
            formatButtonVisible: false,
            // leftChevronVisible: !state.isLoading,
            // rightChevronVisible: !state.isLoading,
            // rightChevronVisible:
            //     _focusedDate.isBefore(nowDate),
          ),
          headerVisible: false,

          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) =>
                CalendarItemCurrencyDetails(
              itemsByDates: itemsByDates,
              day: day,
            ),
            todayBuilder: (context, day, focusedDay) =>
                CalendarItemCurrencyDetails(
              itemsByDates: itemsByDates,
              day: day,
            ),
            selectedBuilder: (context, day, selectedDay) =>
                CalendarItemCurrencyDetails(
              itemsByDates: itemsByDates,
              day: day,
              isSelected: true,
            ),
          ),
          onPageChanged: (focusedDay) {
            onChangedMonth.call(focusedDay);
          },
        ),
      ],
    );
  }
}
