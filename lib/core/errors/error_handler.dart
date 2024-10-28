import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class ErrorHandler {
  static void crashlyticsLogError(dynamic error, StackTrace stackTrace,
      {String? reason}) async {
    await FirebaseCrashlytics.instance
        .recordError(error, stackTrace, reason: reason);
  }
}
