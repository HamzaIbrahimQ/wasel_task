import 'package:connectivity_plus/connectivity_plus.dart';

/// This mixin for all reusable functions
mixin Utility {
  Future<bool> checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
      /// Connected
      return true;
    } else {
      /// Not connected
      return false;
    }
  }
}
