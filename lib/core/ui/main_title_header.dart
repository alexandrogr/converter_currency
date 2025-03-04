import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MainTitleHeader extends StatelessWidget {
  const MainTitleHeader({
    super.key,
    required this.title,
    this.textAlign,
    this.padding,
  });

  final String title;
  final TextAlign? textAlign;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: AppTheme.primaryColor,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
