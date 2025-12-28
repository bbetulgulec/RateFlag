import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

@immutable
abstract class InternetState {
  const InternetState();
}

class NetworkInitial extends InternetState {
  const NetworkInitial();
}

class NetworkConnected extends InternetState {
  final List<ConnectivityResult> connectivityTypes;

  const NetworkConnected(this.connectivityTypes);
}

class NetworkDisconnected extends InternetState {
  const NetworkDisconnected();
}
