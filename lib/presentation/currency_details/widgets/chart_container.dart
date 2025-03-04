import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:currency_calculator/core/utils/log_mixin.dart';
import 'package:currency_calculator/domain/entities/currency_details/currency_rate_by_date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartContainer extends StatelessWidget with LogMixin {
  const ChartContainer({super.key, required this.items, required this.onTaped});

  final List<CurrencyRateByDate> items;
  final Function(CurrencyRateByDate item) onTaped;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      // title: ChartTitle(text: 'Sales Data'),
      // legend: Legend(isVisible: true),
      legend: Legend(isVisible: false),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        header: "",
        // format: 'point.y',
        canShowMarker: false, // Hide legend marker (color dot)
      ),
      selectionType: SelectionType.point, // Select individual points

      series: [
        SplineAreaSeries<CurrencyRateByDate, DateTime>(
          animationDuration: 700,
          dataSource: items,
          xValueMapper: (CurrencyRateByDate data, _) =>
              data.date, // Use DateTime for X-axis
          yValueMapper: (CurrencyRateByDate data, _) => data.value,
          name: 'Currency',
          gradient: LinearGradient(
            colors: [AppTheme.primaryColor, Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderColor: Colors.blue.withAlpha(100),
          borderWidth: 2,
          selectionBehavior: SelectionBehavior(
            enable: true,
          ), // Enable selection
          markerSettings: MarkerSettings(isVisible: true), // Show markers
          onPointTap: (pointInteractionDetails) {
            log("Chart point tapped: ${pointInteractionDetails.pointIndex}");

            if (pointInteractionDetails.pointIndex != null) {
              onTaped.call(items[pointInteractionDetails.pointIndex!]);
            }
          },
        ),
      ],
      primaryXAxis: DateTimeAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift, // Adjusts label position
        dateFormat: DateFormat.MMMd(), // Format as Jan 1, Jan 5, etc.
        intervalType: DateTimeIntervalType.days, // Show X-axis labels in days
      ),
      primaryYAxis: NumericAxis(),
    );
  }
}
