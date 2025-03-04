import 'dart:async';
import 'dart:developer';

import 'package:currency_calculator/core/router/auto_route.dart';
import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:currency_calculator/injectable.dart';
import 'package:flutter/material.dart';

void main() async {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();

    // const String environment = String.fromEnvironment('ENV', defaultValue: 'dev');
    // configureDependencies(environment);
    // configureDependencies(Env.dev);
    configureDependencies(Env.demo);

    // getIt<LocalDatabase>();

    // Bloc.observer = TalkerBlocObserver(
    //   settings: TalkerBlocLoggerSettings(
    //     enabled: true,
    //     printEventFullData: false,
    //     printStateFullData: false,
    //     printChanges: true,
    //     printClosings: true,
    //     printCreations: true,
    //     printEvents: true,
    //     printTransitions: true,
    //     // // If you want log only AuthBloc transitions
    //     // transitionFilter: (bloc, transition) =>
    //     //     bloc.runtimeType.toString() == 'AuthBloc',
    //     // // If you want log only AuthBloc events
    //     // eventFilter: (bloc, event) => bloc.runtimeType.toString() == 'AuthBloc',
    //   ),
    // );

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
      title: 'Demo Currency',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: getIt<AppRouter>().config(),
    );
  }
}
