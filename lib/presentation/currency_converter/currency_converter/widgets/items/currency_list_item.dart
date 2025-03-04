import 'package:currency_calculator/core/helpers/number_helper.dart';
import 'package:currency_calculator/core/ui/bordered_default.dart';
import 'package:flutter/material.dart';

class CurrencyListItem extends StatelessWidget {
  const CurrencyListItem({
    super.key,
    required this.currencyCodeFrom,
    required this.currencyNameFrom,
    this.currencyCodeTo,
    this.currencyNameTo,
    this.value,
    this.valueCalculated,
    this.onTap,
    this.child,
  });

  final String? currencyCodeFrom;
  final String? currencyNameFrom;
  final String? currencyCodeTo;
  final String? currencyNameTo;
  final double? value;
  final double? valueCalculated;
  final VoidCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: BorderedContainer(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          spacing: 4.0,
          children: [
            if (child != null) child!,
            Row(
              spacing: 8.0,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${NumberHelper.numberFormat(value)} ${currencyCodeFrom ?? "-"}"),
                      Text(
                        "$currencyNameFrom",
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black26,
                  size: 16.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          "${NumberHelper.numberFormat(valueCalculated)} $currencyCodeTo"),
                      Text(
                        "$currencyNameTo",
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
