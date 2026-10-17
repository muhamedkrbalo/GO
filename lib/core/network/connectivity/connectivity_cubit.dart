import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

enum ConnectivityStatus { connected, disconnected, checking }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  final InternetConnection _internetConnection;
  StreamSubscription<InternetStatus>? _internetSubscription;

  ConnectivityCubit({required InternetConnection internetConnection})
    : _internetConnection = internetConnection,
      super(ConnectivityStatus.connected) {
    _init();
  }

  void _init() {
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
