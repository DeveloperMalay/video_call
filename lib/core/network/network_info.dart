import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      
      // The newer version returns List<ConnectivityResult>
      if (connectivityResult is List) {
        final results = connectivityResult as List<ConnectivityResult>;
        for (final result in results) {
          if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
            return true;
          }
        }
        return false;
      } else {
        // Handle single ConnectivityResult
        final result = connectivityResult;
        return result == ConnectivityResult.mobile || 
               result == ConnectivityResult.wifi;
      }
    } catch (e) {
      // Fallback to true if connectivity check fails
      return true;
    }
  }
}