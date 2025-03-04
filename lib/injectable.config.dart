// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/database/local_cache.dart' as _i232;
import 'core/database/local_database.dart' as _i293;
import 'core/network/dio_client_remote.dart' as _i886;
import 'core/router/auto_route.dart' as _i49;
import 'data/datasources/local/local_datasource_impl.dart' as _i905;
import 'data/datasources/remote/remote_datasource_demo.dart' as _i566;
import 'data/datasources/remote/remote_datasource_impl.dart' as _i757;
import 'data/repositories/currency_repository_demo.dart' as _i1013;
import 'data/repositories/currency_repository_dev.dart' as _i629;
import 'data/repositories/currency_repository_prod.dart' as _i705;
import 'domain/repositories/currency_repository.dart' as _i877;
import 'domain/usecases/fetch_currencies_by_filter.dart' as _i104;
import 'domain/usecases/fetch_currency_details.dart' as _i107;
import 'domain/usecases/history/fetch_history_rates.dart' as _i272;
import 'domain/usecases/history/save_history_rates.dart' as _i484;
import 'domain/usecases/settings/fetch_supported_currencies.dart' as _i197;
import 'domain/usecases/settings/fetch_supported_exchanges.dart' as _i930;

const String _demo = 'demo';
const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i49.AppRouter>(() => _i49.AppRouter());
    gh.lazySingleton<_i293.LocalDatabase>(() => _i293.LocalDatabase());
    gh.lazySingleton<_i886.DioClientRemote>(() => _i886.DioClientRemote());
    gh.factory<_i905.LocalDataSourceImpl>(() => _i905.LocalDataSourceImpl(
          gh<_i293.LocalDatabase>(),
          gh<_i232.LocalCache>(),
        ));
    gh.factory<_i566.RemoteDataSourceDemo>(
        () => _i566.RemoteDataSourceDemo(gh<_i886.DioClientRemote>()));
    gh.factory<_i757.RemoteDataSourceImpl>(
        () => _i757.RemoteDataSourceImpl(gh<_i886.DioClientRemote>()));
    gh.factory<_i877.CurrencyRepository>(
      () => _i1013.CurrencyRepositoryDemo(
        gh<_i566.RemoteDataSourceDemo>(),
        gh<_i905.LocalDataSourceImpl>(),
      ),
      registerFor: {_demo},
    );
    gh.factory<_i877.CurrencyRepository>(
      () => _i629.CurrencyRepositoryDev(
        gh<_i757.RemoteDataSourceImpl>(),
        gh<_i905.LocalDataSourceImpl>(),
      ),
      registerFor: {_dev},
    );
    gh.factory<_i877.CurrencyRepository>(
      () => _i705.CurrencyRepositoryProd(
        gh<_i757.RemoteDataSourceImpl>(),
        gh<_i905.LocalDataSourceImpl>(),
      ),
      registerFor: {_prod},
    );
    gh.factory<_i104.FetchCurrenciesByFilter>(
        () => _i104.FetchCurrenciesByFilter(gh<_i877.CurrencyRepository>()));
    gh.factory<_i197.FetchSupportedCurrencies>(
        () => _i197.FetchSupportedCurrencies(gh<_i877.CurrencyRepository>()));
    gh.factory<_i930.FetchSupportedeEchange>(
        () => _i930.FetchSupportedeEchange(gh<_i877.CurrencyRepository>()));
    gh.factory<_i272.FetchHistoryRates>(
        () => _i272.FetchHistoryRates(gh<_i877.CurrencyRepository>()));
    gh.factory<_i484.SaveHistoryRates>(
        () => _i484.SaveHistoryRates(gh<_i877.CurrencyRepository>()));
    gh.factory<_i107.FetchCurrencyDetails>(
        () => _i107.FetchCurrencyDetails(gh<_i877.CurrencyRepository>()));
    return this;
  }
}
