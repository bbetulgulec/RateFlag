import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:rate_flag/features/rate_flag/core/internet/cubit/internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity _connectivity;
  final InternetConnection _checker;

  StreamSubscription<List<ConnectivityResult>>? _subscription;
  Timer? _internetTimer;

  InternetCubit({Connectivity? connectivity, InternetConnection? checker})
    : _connectivity = connectivity ?? Connectivity(),
      _checker = checker ?? InternetConnection(),
      super(const NetworkInitial()) {
    _init();
  }

  Future<void> _init() async {
    await _checkInternet();

    _startListening();

    _internetTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _checkInternet(),
    );
  }

  Future<void> _checkInternet() async {
    final results = await _connectivity.checkConnectivity();
    final hasInternet = await _checker.hasInternetAccess;

    if (results.contains(ConnectivityResult.none) || !hasInternet) {
      if (state is! NetworkDisconnected) {
        emit(const NetworkDisconnected());
      }
    } else {
      if (state is! NetworkConnected) {
        emit(NetworkConnected(results));
      }
    }
  }

  void _startListening() {
    _subscription = _connectivity.onConnectivityChanged.listen((results) async {
      final hasInternet = await _checker.hasInternetAccess;

      if (results.contains(ConnectivityResult.none) || !hasInternet) {
        emit(const NetworkDisconnected());
      } else {
        emit(NetworkConnected(results));
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _internetTimer?.cancel();
    return super.close();
  }
}
