import 'package:currency_calculator/injectable.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies(String env) {
  getIt.init(environment: env);
  // getIt.registerSingleton(LocalCache());
}

abstract class Env {
  static const dev = 'dev';
  static const prod = 'prod';
  static const demo = 'demo';
}

// @module
// abstract class RegisterModule {
//   @dev
//   @LazySingleton(as: testB)
//   testB get testBImplDev => testBImpl();

//   @prod
//   @LazySingleton(as: testB)
//   testB get testBImplProd => testBImpl();
// }
