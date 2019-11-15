import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/material.dart';

class StateModel with ChangeNotifier {
  Stopwatch _watch;
  Timer _timer;
  bool _locationPermissions ;
  LocationData _userLocation;

  Duration get currentDuration => _currentDuration;
  Duration _currentDuration = Duration.zero;
  bool get isRunning => _timer != null;
  bool get locationPermissions => _locationPermissions;
  LocationData get currentUserLocation => _userLocation;

  set locationPermissions(bool locationPermission) => _locationPermissions = locationPermission;
  set userLocation(LocationData userLocation) => _userLocation = userLocation;

  StateModel() {
    _watch = Stopwatch();
    _locationPermissions = false;
  }

  void _onTick(Timer timer) {
    _currentDuration = _watch.elapsed;
    notifyListeners();
  }

  /// start timer
  void start() {
    if (_timer != null) return;
    _timer = Timer.periodic(Duration(seconds: 1), _onTick);
    _watch.start();

    notifyListeners();
  }

  /// stop timer
  void stop() {
    _timer?.cancel();
    _timer = null;
    _watch.stop();
    _currentDuration = _watch.elapsed;
    notifyListeners();
  }

  /// reset timer
  void reset() {
    stop();
    _watch.reset();
    _currentDuration = Duration.zero;
    notifyListeners();
  }
}
