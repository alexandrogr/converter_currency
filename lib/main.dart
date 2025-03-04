import 'dart:async';
import 'dart:developer';

import 'package:currency_calculator/core/router/auto_route.dart';
import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:currency_calculator/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';

void main() async {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();

    const String environment =
        String.fromEnvironment('ENV', defaultValue: Env.demo);
    configureDependencies(environment);

    if (environment == Env.dev) {
      Bloc.observer = TalkerBlocObserver(
        settings: TalkerBlocLoggerSettings(
          enabled: true,
          printEventFullData: false,
          printStateFullData: false,
          printChanges: true,
          printClosings: true,
          printCreations: true,
          printEvents: true,
          printTransitions: true,
          // // If you want log only CurrencyBloc transitions
          // transitionFilter: (bloc, transition) =>
          //     bloc.runtimeType.toString() == 'CurrencyBloc',
          // // If you want log only AuthBloc events
          // eventFilter: (bloc, event) => bloc.runtimeType.toString() == 'CurrencyBloc',
        ),
      );
    }

    runApp(const MyApp());
  }, (e, stackTrace) {
    log("Error: $e", error: e, stackTrace: stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Currency Converter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: getIt<AppRouter>().config(),
    );
  }
}
