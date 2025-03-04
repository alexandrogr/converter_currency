import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class RowWithEqualColumns extends StatelessWidget {
  final List<Widget?> children;
  final double space;
  final CrossAxisAlignment? crossAxisAlignment;

  const RowWithEqualColumns({
    super.key,
    required this.children,
    this.space = AppTheme.defaultSpace,
    this.crossAxisAlignment,
  });

  factory RowWithEqualColumns.crossAxisStart({
    required List<Widget> children,
    double space = AppTheme.defaultSpace,
  }) =>
      RowWithEqualColumns(
        children: children,
        space: space,
        crossAxisAlignment: CrossAxisAlignment.start,
      );

  factory RowWithEqualColumns.crossAxisEnd({
    required List<Widget> children,
    double space = AppTheme.defaultSpace,
  }) =>
      RowWithEqualColumns(
        children: children,
        space: space,
        crossAxisAlignment: CrossAxisAlignment.end,
      );

  @override
  Widget build(BuildContext context) {
    final List<Widget> filteredChildren = children
        .where(
          (element) => element != null,
        )
        .map((e) => e!)
        .toList();

    return Row(
      spacing: space,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: filteredChildren.map((e) => Expanded(child: e)).toList(),
    );
  }
}
