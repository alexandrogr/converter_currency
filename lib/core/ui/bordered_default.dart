import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BorderedContainer extends StatelessWidget {
  const BorderedContainer({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor = Colors.white,
  });

  final Widget child;
  final EdgeInsets? padding;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppTheme.defaultBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(70),
            spreadRadius: 0,
            blurRadius: 6,
            offset: Offset(0, 1.5),
          ),
        ],
      ),
      child: child,
    );
  }
}
