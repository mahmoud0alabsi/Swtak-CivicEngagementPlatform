import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionHandler {
  // Singleton instance
  static final InternetConnectionHandler _instance =
      InternetConnectionHandler._internal();

  InternetConnectionHandler._internal();

  factory InternetConnectionHandler() {
    return _instance;
  }

  static Future<bool> hasInternetConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } on SocketException catch (_) {
        return false;
      }
    } else {
      return false;
    }
  }

  static Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return Connectivity().onConnectivityChanged;
  }
}
