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
      spacing: 4.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 10.0,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(8), // Padding inside the container
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200], // Light gray fill color (background)
              borderRadius: BorderRadius.circular(12), // Rounded corners
              border: Border.all(
                // Gray border
                color: Colors.grey,
                width: 1.5, // Border thickness
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(currency?.currencyCode ?? "-"),
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
