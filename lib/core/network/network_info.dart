import 'package:connectivity_plus/connectivity_plus.dart';

/// Thin abstraction over the platform connectivity status, used by the sync
/// engine to know when it may drain the offline queue.
class NetworkInfo {
  NetworkInfo(this._connectivity);

  final Connectivity _connectivity;

  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return results.any((r) => r != ConnectivityResult.none);
  }

  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}
