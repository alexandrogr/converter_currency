import 'package:auto_route/auto_route.dart';
import 'package:currency_calculator/core/helpers/date_helper.dart';
import 'package:currency_calculator/core/ui/scaffold/app_bar_default.dart';
import 'package:currency_calculator/core/utils/log_mixin.dart';
import 'package:currency_calculator/domain/entities/currency_details/currency_rate_by_date.dart';
import 'package:currency_calculator/injectable.dart';
import 'package:currency_calculator/presentation/currency_details/cubit/currency_details_cubit.dart';
import 'package:currency_calculator/presentation/currency_details/widgets/calendar_table.dart';
import 'package:currency_calculator/presentation/currency_details/widgets/chart_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CurrencyDetailsPage extends StatefulWidget {
  final int exchangeId;
  final String codeBase;
  final String codeTo;

  const CurrencyDetailsPage({
    super.key,
    required this.exchangeId,
    required this.codeBase,
    required this.codeTo,
  });

  @override
  State<CurrencyDetailsPage> createState() => _CurrencyDetailsPageState();
}

class _CurrencyDetailsPageState extends State<CurrencyDetailsPage>
    with LogMixin {
  late CurrencyDetailsCubit _cubit;
  final Map<String, List<CurrencyRateByDate>> _items = {};
  final Map<String, double> _itemsByDates = {};
  final List<DateTime> _months = [];
  final DateTime _nowDate = DateTime.now();
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    _cubit = CurrencyDetailsCubit(
      getIt(),
      exchangeId: widget.exchangeId,
      codeBase: widget.codeBase,
      codeTo: widget.codeTo,
    );

    _months.add(DateTime(_nowDate.year, _nowDate.month, 1));

    _focusedDay = DateTime.now();
    // _selectedDay = DateTime.now();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Map<String, double> _itemsToMapByDates(List<CurrencyRateByDate> items) =>
      {for (var item in items) _getDateString(item.date): item.value};

  DateTime _firstDayForMonth(DateTime date) =>
      DateTime(date.year, date.month, 1);

  String _getDateString(DateTime date) => DateHelper.systemFormat(date);
  String _getDateStringForFirstDay(DateTime date) =>
      _getDateString(_firstDayForMonth(date));

  void _changeMonth(DateTime focusedDay) {
    _focusedDay = _firstDayForMonth(focusedDay);

    if (!_months.contains(_focusedDay)) {
      log("Changed month: $_focusedDay");

      _months.add(_focusedDay);
      _selectedDay = null;
      _cubit.changeMonth(focusedDay);
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: "History",
        subtitle: "${widget.codeBase} -> ${widget.codeTo}",
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: BlocProvider(
          create: (context) => _cubit,
          child: BlocConsumer<CurrencyDetailsCubit, CurrencyDetailsState>(
              listener: (context, state) {
            state.mapOrNull(
              loaded: (value) {
                _itemsByDates.addAll(_itemsToMapByDates(value.items));
                _items[_getDateString(_firstDayForMonth(_focusedDay))] =
                    value.items;
              },
            );
          }, builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CalendarTable(
                      nowDate: _nowDate,
                      focusedDay: _focusedDay,
                      selectedDay: _selectedDay,
                      isLoadingData: state.isLoading,
                      itemsByDates: _itemsByDates,
                      onChangedMonth: _changeMonth,
                      onSelectedDay: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay =
                              selectedDay == _selectedDay ? null : selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                    ),
                  ),
                ),
                // SliverToBoxAdapter(
                //   child: MainTitleHeader(
                //     title: "Graph",
                //     textAlign: TextAlign.start,
                //     padding: EdgeInsets.only(
                //       bottom: 2.0,
                //       top: 8.0,
                //       left: 8.0,
                //       right: 8.0,
                //     ),
                //   ),
                // ),
                SliverToBoxAdapter(
                  child: state.maybeWhen(
                    loading: (_) =>
                        Center(child: CircularProgressIndicator.adaptive()),
                    loaded: (form, items) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ChartContainer(
                            items: _items[
                                    _getDateStringForFirstDay(_focusedDay)] ??
                                [],
                            onTaped: (item) {
                              Future.delayed(Duration(milliseconds: 1500), () {
                                setState(() {
                                  _selectedDay = item.date;
                                });
                              });
                            }),
                      );
                    },
                    orElse: () => Center(
                      child:
                          Text("Something went wrong, please try again later"),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
