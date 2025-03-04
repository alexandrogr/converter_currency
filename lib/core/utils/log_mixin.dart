import 'dart:developer' as developer;

mixin LogMixin on Object {
  void log(Object object) {
    developer.log("$object", name: "$runtimeType");
  }

  void logError(Object object, StackTrace stackTrace) =>
      developer.log("$object",
          error: object, stackTrace: stackTrace, name: "$runtimeType");

  void logMessage(
    String message, {
    Object? object,
  }) {
    developer.log("$message${object != null ? ": $object" : ""}",
        name: "$runtimeType");
  }

  void logMessageWithPrefix(
    String message, {
    required String prefix,
    Object? object,
    bool isGroup = false,
  }) {
    logMessage("${isGroup ? "[" : ""}$prefix${isGroup ? "]" : ""} $message",
        object: object);
  }

  void logMessages(
    List<String> messages, {
    Object? object,
  }) {
    developer.log("${messages.join(", ")}${object != null ? ": $object" : ""}",
        name: "$runtimeType");
  }

  /// Helper function to extract the current method name from the stack trace
  String getCurrentMethodNameLog() {
    final frames = StackTrace.current.toString().split('\n');

    // The second frame in the stack trace contains the current method
    final frame = frames.elementAtOrNull(1);

    if (frame != null) {
      // Extract the method name from the frame. For example, given this input string:
      // #1      LoggerAnalyticsClient.trackAppOpen (package:flutter_ship_app/src/monitoring/logger_analytics_client.dart:28:9)
      // The code will return: LoggerAnalyticsClient.trackAppOpen
      final tokens = frame
          .replaceAll('<anonymous closure>', '<anonymous_closure>')
          .split(' ');
      final methodName = tokens.elementAtOrNull(tokens.length - 2);

      if (methodName != null) {
        // if the class name is included, remove it, otherwise return as is
        final methodTokens = methodName.split('.');

        // ignore_for_file:avoid-unsafe-collection-methods
        return methodTokens.length >= 2 &&
                methodTokens[1] != '<anonymous_closure>'
            ? (methodTokens.elementAtOrNull(1) ?? '')
            : methodName;
      }
    }

    return '';
  }
}
