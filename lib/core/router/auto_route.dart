import 'package:auto_route/auto_route.dart';
import 'package:currency_calculator/core/router/auto_route.gr.dart';
import 'package:injectable/injectable.dart';

@injectable
@AutoRouterConfig(generateForDir: ['lib'])
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: CurrencyConverterRoute.page,
          initial: true,
        ),
        // AutoRoute(
        //   page: TradeRoute.page,
        //   initial: true,
        // ),
        AutoRoute(
          path: '/history',
          page: HistoryRoute.page,
        ),
        AutoRoute(
          path: '/currency-details/:codeBase/:codeTo',
          page: CurrencyDetailsRoute.page,
        ),

        // AutoRoute(path: '/login', page: LoginRoute.page),
        RedirectRoute(path: '*', redirectTo: '/'),
      ];
}
