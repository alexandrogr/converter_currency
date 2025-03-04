import 'package:auto_route/auto_route.dart';
import 'package:currency_calculator/core/helpers/snackbar_helper.dart';
import 'package:currency_calculator/core/router/auto_route.gr.dart';
import 'package:currency_calculator/core/ui/scaffold/app_bar_default.dart';
import 'package:currency_calculator/injectable.dart';
import 'package:currency_calculator/presentation/history/cubit/history_cubit.dart';
import 'package:currency_calculator/presentation/history/data/history_list_item_state_data.dart';
import 'package:currency_calculator/presentation/history/widgets/history_list_item.dart';
import 'package:currency_calculator/presentation/history/widgets/history_title_list_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit(getIt()),
      child: Scaffold(
        appBar: AppBarDefault(
          title: 'History',
        ),
        body: BlocConsumer<HistoryCubit, HistoryState>(
          listener: (context, state) => state.mapOrNull(
              loaded: (value) {
                if (kDebugMode) {
                  SnackBarHelper.showSnackBar(context, 'History loaded!');
                }

                return null;
              },
              error: (value) => SnackBarHelper.showSnackBar(
                  context, 'Error: ${value.error}')),
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => Center(
                child: Column(
                  spacing: 8.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Loading ..."),
                    CircularProgressIndicator.adaptive(),
                  ],
                ),
              ),
              loaded: (items) => ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  if (item is HistoryListItemStateTitleData) {
                    return HistoryTitleListItem(
                      date: item.date,
                    );
                  } else if (item is HistoryListItemStateModelData) {
                    return HistoryListItem(
                      model: item.model,
                      onTap: () => context.router.push(CurrencyDetailsRoute(
                        exchangeId: item.model.exchangeId ?? -1,
                        codeBase: item.model.currencyCodeFrom ?? "",
                        codeTo: item.model.currencyCodeTo ?? "",
                      )),
                    );
                  }

                  return SizedBox.shrink();
                },
              ),
              orElse: () => Center(
                child: Text("Empty list, need to add calcaultion"),
              ),
            );
          },
        ),
      ),
    );
  }
}
