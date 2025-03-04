import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({
    super.key,
    required this.title,
    this.padding,
  });

  final String title;
  final EdgeInsets? padding;

  factory EmptyContainer.withoutPadding({
    required String title,
  }) {
    return EmptyContainer(
      title: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: AppTheme.hintTextColor),
        ),
      ),
    );
  }
}
