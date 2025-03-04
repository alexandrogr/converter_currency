// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:currency_calculator/presentation/currency_converter/currency_converter/pages/currency_converter_page.dart'
    as _i1;
import 'package:currency_calculator/presentation/currency_details/pages/currency_details_page.dart'
    as _i2;
import 'package:currency_calculator/presentation/history/pages/history_page.dart'
    as _i3;
import 'package:flutter/material.dart' as _i5;

/// generated route for
/// [_i1.CurrencyConverterPage]
class CurrencyConverterRoute extends _i4.PageRouteInfo<void> {
  const CurrencyConverterRoute({List<_i4.PageRouteInfo>? children})
    : super(CurrencyConverterRoute.name, initialChildren: children);

  static const String name = 'CurrencyConverterRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.CurrencyConverterPage();
    },
  );
}

/// generated route for
/// [_i2.CurrencyDetailsPage]
class CurrencyDetailsRoute extends _i4.PageRouteInfo<CurrencyDetailsRouteArgs> {
  CurrencyDetailsRoute({
    _i5.Key? key,
    required int exchangeId,
    required String codeBase,
    required String codeTo,
    List<_i4.PageRouteInfo>? children,
  }) : super(
         CurrencyDetailsRoute.name,
         args: CurrencyDetailsRouteArgs(
           key: key,
           exchangeId: exchangeId,
           codeBase: codeBase,
           codeTo: codeTo,
         ),
         initialChildren: children,
       );

  static const String name = 'CurrencyDetailsRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CurrencyDetailsRouteArgs>();
      return _i2.CurrencyDetailsPage(
        key: args.key,
        exchangeId: args.exchangeId,
        codeBase: args.codeBase,
        codeTo: args.codeTo,
      );
    },
  );
}

class CurrencyDetailsRouteArgs {
  const CurrencyDetailsRouteArgs({
    this.key,
    required this.exchangeId,
    required this.codeBase,
    required this.codeTo,
  });

  final _i5.Key? key;

  final int exchangeId;

  final String codeBase;

  final String codeTo;

  @override
  String toString() {
    return 'CurrencyDetailsRouteArgs{key: $key, exchangeId: $exchangeId, codeBase: $codeBase, codeTo: $codeTo}';
  }
}

/// generated route for
/// [_i3.HistoryPage]
class HistoryRoute extends _i4.PageRouteInfo<void> {
  const HistoryRoute({List<_i4.PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.HistoryPage();
    },
  );
}
