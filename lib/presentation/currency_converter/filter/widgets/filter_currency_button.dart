import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:flutter/material.dart';

class FilterCurrencyButton extends StatelessWidget {
  const FilterCurrencyButton({
    super.key,
    required this.title,
    required this.currency,
    required this.onTap,
    required this.withAbilityToUnselect,
  });

  final String title;
  final Currency? currency;
  final VoidCallback onTap;
  final bool withAbilityToUnselect;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12.0,
            color: AppTheme.hintTextColor,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.inputFillColor,
              borderRadius:
                  BorderRadius.circular(AppTheme.inputBorderRadius - 2.0),
              border: Border.all(
                color: AppTheme.defaultBorderInputColor,
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(currency?.currencyCode ?? "Not selected"),
                Text(
                  currency?.currencyName ?? "Need to select currency",
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.black54,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
