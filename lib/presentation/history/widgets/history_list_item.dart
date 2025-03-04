import 'package:currency_calculator/core/helpers/date_helper.dart';
import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:currency_calculator/domain/entities/history/history_rate.dart';
import 'package:currency_calculator/presentation/currency_converter/currency_converter/widgets/items/currency_list_item.dart';
import 'package:flutter/material.dart';

class HistoryListItem extends StatelessWidget {
  const HistoryListItem({
    super.key,
    required this.model,
    required this.onTap,
  });

  final HistoryRate model;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 8.0,
        children: [
          if (model.createdAt != null)
            ...model.items.map((e) => Padding(
                  // padding: EdgeInsets.only(left: 16.0),
                  padding: EdgeInsets.zero,
                  child: CurrencyListItem(
                    currencyCodeFrom: e.currency?.currencyCode,
                    currencyNameFrom: e.currency?.currencyName,
                    currencyCodeTo: e.code,
                    currencyNameTo: e.name,
                    value: e.value,
                    valueCalculated: e.valueByRate,
                    onTap: onTap,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            model.exchangeTitle ?? "-",
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        Text(
                          DateHelper.formatDate(model.createdAt!),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.black38,
                          ),
                        )
                      ],
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
