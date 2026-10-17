import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

enum ConnectivityStatus { connected, disconnected, checking }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  // final Connectivity _connectivity;
  final InternetConnection _internetConnection;
  // StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  StreamSubscription<InternetStatus>? _internetSubscription;

  ConnectivityCubit({Connectivity? connectivity, InternetConnection? internetConnection})
    : // _connectivity = connectivity ?? Connectivity(),
      _internetConnection = internetConnection ?? InternetConnection(),
      super(ConnectivityStatus.connected) {
    _init();
  }

  void _init() {
    // Listen to connectivity changes (WiFi, Mobile, etc.)
    // _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
    //   (results) => _checkInternetConnection(),
    // );

    // Listen to actual internet connection status
    _internetSubscription = _internetConnection.onStatusChange.listen((status) {
      if (status == InternetStatus.connected) {
        emit(ConnectivityStatus.connected);
      } else {
        emit(ConnectivityStatus.disconnected);
      }
    });

    // Initial check
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    emit(ConnectivityStatus.checking);
    final hasInternet = await _internetConnection.hasInternetAccess;
    emit(hasInternet ? ConnectivityStatus.connected : ConnectivityStatus.disconnected);
  }

  Future<void> checkConnection() async {
    await _checkInternetConnection();
  }

  @override
  Future<void> close() async {
    await _internetSubscription?.cancel();
    return super.close();
  }
}
