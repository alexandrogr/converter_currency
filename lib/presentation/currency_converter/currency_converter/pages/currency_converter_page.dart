import 'package:auto_route/auto_route.dart';
import 'package:currency_calculator/core/helpers/snackbar_helper.dart';
import 'package:currency_calculator/core/ui/empty_container.dart';
import 'package:currency_calculator/core/ui/forms/main_radio_field.dart';
import 'package:currency_calculator/core/ui/scaffold/app_bar_button.dart';
import 'package:currency_calculator/core/ui/scaffold/app_bar_default.dart';
import 'package:currency_calculator/core/utils/log_mixin.dart';
import 'package:currency_calculator/domain/entities/exchange/exchange.dart';
import 'package:currency_calculator/injectable.dart';
import 'package:currency_calculator/presentation/currency_converter/currency_converter/bloc/currency_bloc.dart';
import 'package:currency_calculator/presentation/currency_converter/currency_converter/widgets/currency_list_container.dart';
import 'package:currency_calculator/presentation/currency_converter/filter/cubit/filter_currency_cubit.dart';
import 'package:currency_calculator/presentation/currency_converter/filter/data/filter_state_data.dart';
import 'package:currency_calculator/presentation/currency_converter/filter/widgets/filter_container.dart';
import 'package:currency_calculator/presentation/currency_converter/settings/cubit/settings_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage>
    with LogMixin {
  late SettingsCubit _settingsCubit;

  @override
  void initState() {
    super.initState();

    _settingsCubit = SettingsCubit(getIt(), getIt());
  }

  @override
  void dispose() {
    _settingsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _settingsCubit,
        ),
        BlocProvider(
          create: (context) => FilterCurrencyCubit(),
        ),
        BlocProvider(
          create: (context) => CurrencyBloc(getIt(), getIt()),
        ),
      ],
      child: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) => state.mapOrNull(
            loaded: (value) {
              if (kDebugMode) {
                SnackBarHelper.showSnackBar(context, 'Settings loaded!');
              }

              context
                  .read<FilterCurrencyCubit>()
                  .setExchange(value.form.selectedExcahnge);

              context.read<CurrencyBloc>().add(
                  CurrencyEvent.addSupportedCurrencies(
                      value.form.selectedExcahnge, value.form.currencies));
              return null;
            },
            error: (value) =>
                SnackBarHelper.showSnackBar(context, 'Error: ${value.error}')),
        builder: (context, state) {
          return Scaffold(
              appBar: AppBarDefault(
                title: 'Currencies',
                actions: [
                  AppBarButton(
                    icon: const Icon(Icons.list),
                    onTap: () => context.router.pushNamed('/history'),
                  )
                ],
              ),
              body: SafeArea(
                bottom: false,
                child: CustomScrollView(
                  slivers: [
                    if (!state.isFirstLoading)
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 50.0,
                          child: MainRadioField<Exchange>(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            initialValue:
                                _settingsCubit.state.form.selectedExcahnge,
                            items: _settingsCubit.state.form.excahnges
                                .map(
                                  (e) => MainRadioFieldItem<Exchange>(
                                    value: e,
                                    title: e.title,
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              // log("Changed exchange to $value");

                              if (_settingsCubit.state.form.selectedExcahnge !=
                                  value) {
                                _settingsCubit.changeExchange(value);
                              }
                            },
                          ),
                        ),
                      ),
                    ...state.maybeWhen(
                      loading: (_, isFirstLoading) => [
                        SliverFillRemaining(
                          child: Center(
                            child: Column(
                              spacing: 8.0,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                EmptyContainer(title: "Loading required data"),
                                CircularProgressIndicator.adaptive(),
                              ],
                            ),
                          ),
                        )
                      ],
                      loaded: (items) => [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 8.0,
                                  bottom: 8.0,
                                ),
                                child: FilterContainer(
                                  onChanged: (form) {
                                    context
                                        .read<CurrencyBloc>()
                                        .add(CurrencyEvent.filterData(form));
                                  },
                                  onChangedValue: (form) {
                                    context
                                        .read<CurrencyBloc>()
                                        .add(CurrencyEvent.filterValue(form));
                                  },
                                  onCalculate: (form) {
                                    context
                                        .read<CurrencyBloc>()
                                        .add(CurrencyEvent.filterData(form));
                                  },
                                  onChangedBaseCurrency:
                                      (FilterStateData form) => context
                                          .read<CurrencyBloc>()
                                          .add(CurrencyEvent.loadData(form)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_settingsCubit.state.form.selectedExcangeIsNotNull)
                          CurrencyListContainer(
                            exchangeId:
                                _settingsCubit.state.form.selectedExcahnge!.id,
                            onError: (error) => SnackBarHelper.showSnackBar(
                                context, 'Error: $error'),
                          ),
                      ],
                      orElse: () => [
                        SliverFillRemaining(
                          child: EmptyContainer(
                              title:
                                  "Something went wrong, please try again later"),
                        )
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.paddingOf(context).bottom,
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
