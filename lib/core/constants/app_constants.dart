class ApiConstants {
  static const String baseUrl = String.fromEnvironment('BASE_URL');
  static const String apiKey =
      String.fromEnvironment('API_KEY', defaultValue: "");

  // for example
  // https://www.jsonapi.co/public-api/CurrencyFreaks%20API
  // https://currencyfreaks.com/#SupportedCurrencies
  // https://github.com/fawazahmed0/exchange-api
}
