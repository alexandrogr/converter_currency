class DemoConstants {
  static const int countSuccessfulAttempts =
      int.fromEnvironment('COUNT_SUCCESSFUL_ATTEMPTS', defaultValue: 3);
  static const int requestDelayMilliseconds =
      int.fromEnvironment('REQUEST_DELAY_MILLISECONDS', defaultValue: 700);
  static const String filePath = 'assets/data/currencies.json';
}
