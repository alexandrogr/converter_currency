// for currencyfreaks

import 'dart:developer';

import 'package:currency_calculator/core/constants/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

// @injectable
@LazySingleton()
class DioClientRemote {
  final Dio _dio;
  Dio get dio => _dio;

  DioClientRemote()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        ) {
    _dio.interceptors
      ..add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            options.queryParameters.addAll({
              'api': ApiConstants.apiKey,
              // 'currencies' : ['']
            });
            return handler.next(options);
          },
          onResponse: (response, handler) {
            // Optionally handle responses
            return handler.next(response);
          },
          onError: (DioError error, handler) {
            // Optionally handle errors
            return handler.next(error);
          },
        ),
      )
      ..add(
        LogInterceptor(
          request: true, // Logs the request
          requestHeader: true, // Logs request headers
          requestBody: true, // Logs request body
          responseHeader: true, // Avoid logging response headers (optional)
          responseBody: true, // Logs response body
          error: true, // Logs errors
          logPrint: (object) => log("$object",
              name: "$runtimeType"), // Customize logger (optional)
        ),
      );
  }
}
