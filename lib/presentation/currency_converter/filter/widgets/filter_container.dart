import 'package:currency_calculator/core/ui/bordered_default.dart';
import 'package:currency_calculator/domain/entities/currency_converter/currency.dart';
import 'package:currency_calculator/presentation/currency_converter/filter/cubit/filter_currency_cubit.dart';
import 'package:currency_calculator/presentation/currency_converter/filter/data/filter_state_data.dart';
import 'package:currency_calculator/presentation/currency_converter/filter/formatters/decimal_formatter.dart';
import 'package:currency_calculator/presentation/currency_converter/filter/widgets/filter_currency_button.dart';
import 'package:currency_calculator/presentation/currency_converter/settings/cubit/settings_cubit.dart';
import 'package:currency_calculator/presentation/supported_currencies_page/pages/supported_currencies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterContainer extends StatelessWidget {
  const FilterContainer({
    super.key,
    required this.onChanged,
    required this.onChangedValue,
    required this.onCalculate,
    required this.onChangedBaseCurrency,
  });

  final Function(FilterStateData form) onChanged;
  final Function(FilterStateData form) onCalculate;
  final Function(FilterStateData form) onChangedValue;
  final Function(FilterStateData form)
      onChangedBaseCurrency; // need if use api for calculating

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterCurrencyCubit, FilterCurrencyState>(
      listener: (context, state) {
        if (state.oldForm.fromCurrency != state.form.fromCurrency) {
          onChangedBaseCurrency.call(state.form);
        } else if (state.oldForm.value != state.form.value) {
          onChangedValue.call(state.form);
        } else {
          onChanged.call(state.form);
        }
      },
      builder: (context, state) {
        final filterCurrencyCubit = context.read<FilterCurrencyCubit>();

        return BorderedContainer(
          padding: EdgeInsets.all(8), // Padding of 8

          child: Column(
            spacing: 8.0,
            children: [
              Row(
                spacing: 8.0,
                children: [
                  Expanded(
                      child: FilterCurrencyButton(
                    title: "Base currency",
                    currency: state.form.fromCurrency,
                    withAbilityToUnselect: false,
                    onTap: () => _onTapCurrency(
                      context,
                      value: state.form.fromCurrency,
                      ignoreValue: state.form.toCurrency,
                      onChanged: (currency) =>
                          filterCurrencyCubit.changeCurrencyFrom(currency),
                    ),
                  )),
                  if (state.form.isSelectedBaseCurrency)
                    Expanded(
                        child: FilterCurrencyButton(
                      title: "Quote currency",
                      currency: state.form.toCurrency,
                      withAbilityToUnselect: true,
                      onTap: () => _onTapCurrency(
                        context,
                        value: state.form.toCurrency,
                        ignoreValue: state.form.fromCurrency,
                        onChanged: (currency) =>
                            filterCurrencyCubit.changeCurrencyTo(currency),
                      ),
                    ))
                ],
              ),
              if (state.form.isSelectedBaseCurrency)
                Row(
                  spacing: 8.0,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintStyle:
                              Theme.of(context).inputDecorationTheme.hintStyle,
                          labelStyle:
                              Theme.of(context).inputDecorationTheme.labelStyle,
                          floatingLabelStyle: Theme.of(context)
                              .inputDecorationTheme
                              .floatingLabelStyle,
                          enabledBorder: Theme.of(context)
                              .inputDecorationTheme
                              .enabledBorder,
                          focusedBorder: Theme.of(context)
                              .inputDecorationTheme
                              .focusedBorder,
                          border: Theme.of(context).inputDecorationTheme.border,
                          hintText: "Enter value",
                          counterText: "",
                        ),
                        maxLength: 8,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}')),
                          DecimalTextInputFormatter(decimalRange: 2)
                        ],
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: true, signed: true),
                        onSubmitted: (value) =>
                            onCalculate.call(filterCurrencyCubit.state.form),
                        onChanged: (str) {
                          late final double value;

                          try {
                            value = double.parse(str);
                          } catch (e) {
                            value = 0.0; //
                          }

                          if (filterCurrencyCubit.state.form.value != value) {
                            filterCurrencyCubit.changeValue(value);
                          }
                        },
                      ),
                    ),
                    // if use api we need execute only one size
                    // if (filterCurrencyCubit.state.form.hasValue)
                    //   CupertinoButton(
                    //     child: Text("Get value"),
                    //     onPressed: () {
                    //       FocusScope.of(context).unfocus();
                    //       onCalculate.call(filterCurrencyCubit.state.form);
                    //     },
                    //   ),
                  ],
                )
            ],
          ),
        );
      },
    );
  }

  void _onTapCurrency(
    BuildContext context, {
    required Currency? value,
    required Currency? ignoreValue,
    required void Function(Currency? currency) onChanged,
  }) {
    List<Currency> items = context.read<SettingsCubit>().state.maybeMap(
          loaded: (value) => value.form.currencies,
          orElse: () => [],
        );

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SupportedCurrenciesPage(
                onSelected: onChanged,
                selectedValue: value,
                ignoreValue: ignoreValue,
                items: items,
              )),
    );
  }
}
