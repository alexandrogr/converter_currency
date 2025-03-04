import 'package:auto_route/auto_route.dart';
import 'package:currency_calculator/core/router/auto_route.gr.dart';
import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:currency_calculator/core/ui/buttons/main_button.dart';
import 'package:currency_calculator/core/ui/empty_container.dart';
import 'package:currency_calculator/core/utils/log_mixin.dart';
import 'package:currency_calculator/presentation/currency_converter/currency_converter/bloc/currency_bloc.dart';
import 'package:currency_calculator/presentation/currency_converter/currency_converter/widgets/items/currency_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyListContainer extends StatelessWidget with LogMixin {
  const CurrencyListContainer({
    super.key,
    required this.exchangeId,
    required this.onError,
  });

  final int exchangeId;
  final Function(String? error) onError;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrencyBloc, CurrencyState>(
      listener: (context, state) => state.mapOrNull(
        error: (value) => onError.call(value.error),
      ),
      builder: (context, state) {
        final bloc = context.read<CurrencyBloc>();

        return state.maybeWhen(
          loading: (form) => SliverToBoxAdapter(
            child: Center(
              child: Column(
                spacing: 8.0,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text("Initializing application"),
                  CircularProgressIndicator.adaptive(),
                ],
              ),
            ),
          ),
          loaded: (form, items) => SliverList.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: CurrencyListItem(
                      currencyCodeFrom:
                          bloc.state.form.fromCurrency?.currencyCode,
                      currencyNameFrom:
                          bloc.state.form.fromCurrency?.currencyName,
                      currencyCodeTo: items[index].code,
                      currencyNameTo: items[index].currency?.currencyName,
                      value: items[index].value,
                      valueCalculated: items[index].valueByRate,
                      onTap: () => context.router.push(CurrencyDetailsRoute(
                        exchangeId: exchangeId,
                        codeBase:
                            bloc.state.form.fromCurrency?.currencyCode ?? "",
                        codeTo: items[index].code,
                      )),
                    ),
                  )),
          empty: (_) => SliverToBoxAdapter(
            child: EmptyContainer(
              title: "Empty list",
            ),
          ),
          error: (currency, error) => SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                spacing: AppTheme.defaultSpace,
                children: [
                  EmptyContainer.withoutPadding(
                    title: "Something went wrong, please try again later",
                  ),
                  MainButton(
                      title: "Repeat",
                      style: MainButtonStyle.active,
                      isExpanded: false,
                      onPressed: () =>
                          bloc.add(CurrencyEvent.loadData(currency)))
                ],
              ),
            ),
          ),
          orElse: () => SliverToBoxAdapter(
            child: EmptyContainer(
              title: state.form.fromCurrency == null
                  ? "Need to select base currency"
                  : "Undefined state",
            ),
          ),

          //   SliverToBoxAdapter(
          //     child: SizedBox(
          //       height: MediaQuery.paddingOf(context).bottom,
          //     ),
          //   ),
          // ],
        );
      },
    );
  }
}
