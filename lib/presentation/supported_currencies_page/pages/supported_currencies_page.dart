import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:currency_calculator/core/ui/buttons/main_button.dart';
import 'package:currency_calculator/core/ui/empty_container.dart';
import 'package:currency_calculator/core/ui/layout/row_with_equal_columns.dart';
import 'package:currency_calculator/core/ui/scaffold/app_bar_default.dart';
import 'package:currency_calculator/core/ui/scaffold/bottom_bar.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:currency_calculator/presentation/supported_currencies_page/widgets/supported_currencies_item.dart';
import 'package:flutter/material.dart';

class SupportedCurrenciesPage extends StatefulWidget {
  const SupportedCurrenciesPage({
    super.key,
    required this.items,
    this.selectedValue,
    required this.onSelected,
    this.ignoreValue,
    this.withAbilityToUnselect = true,
  });

  final Currency? selectedValue;
  final Currency? ignoreValue;
  final void Function(Currency? currency) onSelected;
  final List<Currency> items;
  final bool withAbilityToUnselect;

  @override
  State<SupportedCurrenciesPage> createState() =>
      _SupportedCurrenciesPageState();
}

class _SupportedCurrenciesPageState extends State<SupportedCurrenciesPage> {
  Currency? _selectedValue;
  String _filterQuery = "";
  late List<Currency> _items;

  @override
  void initState() {
    _selectedValue = widget.selectedValue;
    _items = widget.items.where((e) => e != widget.ignoreValue).toList();
    _items.sort((a, b) => a.currencyCode.compareTo(b.currencyCode));

    super.initState();
  }

  @override
  void dispose() {
    // _onBack();
    super.dispose();
  }

  void _onBack() {
    if (_selectedValue != widget.selectedValue) {
      widget.onSelected.call(_selectedValue);
    }
  }

  List<Currency> get _filteredItems => _items
      .where((e) =>
          _filterQuery.isEmpty ||
          e.currencyCode
              .toLowerCase()
              .trim()
              .contains(_filterQuery.toLowerCase().trim()))
      .toList();

  bool get _isSeleted => _selectedValue != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: 'Supported currencies',
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(8), // Padding of 8

                      child: Column(
                        spacing: AppTheme.defaultSpace,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter search code here',
                            ),
                            maxLength: null,
                            onChanged: (value) => setState(() {
                              _filterQuery = value;

                              if (_selectedValue != null) {
                                _selectedValue = null;
                              }
                            }),
                          ),
                          // MainTitleHeader(
                          //   title: "Available currencies",
                          //   textAlign: TextAlign.start,
                          //   padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  _filteredItems.isEmpty
                      ? SliverToBoxAdapter(
                          child: EmptyContainer(
                            title: "Empty list",
                          ),
                        )
                      : SliverList.builder(
                          itemCount: _filteredItems.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              bottom: 8.0,
                            ),
                            child: SupportedCurrenciesItem(
                              code: _filteredItems[index].currencyCode,
                              title: _filteredItems[index].currencyName ?? "-",
                              isSelected:
                                  _filteredItems[index] == _selectedValue,
                              onTap: () => setState(() {
                                _selectedValue = !widget
                                            .withAbilityToUnselect ||
                                        _selectedValue != _filteredItems[index]
                                    ? _filteredItems[index]
                                    : null;
                              }),
                            ),
                          ),
                        )
                ],
              ),
            ),
            BottomBar(
              child: RowWithEqualColumns(
                children: [
                  MainButton(
                    title: "Close",
                    style: MainButtonStyle.hover,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  MainButton(
                    title: "Accept",
                    style: _isSeleted
                        ? MainButtonStyle.active
                        : MainButtonStyle.hover,
                    onPressed: () {
                      if (_isSeleted) {
                        _onBack();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
