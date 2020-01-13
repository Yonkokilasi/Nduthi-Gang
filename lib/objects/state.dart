import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class StateModel with ChangeNotifier {
  Stopwatch _watch;
  Timer _timer;
  bool _locationPermissions = false;
  Position _userLocation;
  double _speed = 0.0;
  double _distanceTravelled = 0.0;
  Duration currentDuration = Duration.zero;

  bool get locationPermissions => _locationPermissions;
  bool get isRunning => _timer != null;
  double get speed => _speed;
  double get distanceTravelled => _distanceTravelled;
  Position get userLocation => _userLocation;

  set locationPermissions(bool locationPermissions) {
    _locationPermissions = locationPermissions;
    notifyListeners();
  }

  set speed(double speed) {
    _speed = speed;
    notifyListeners();
  }

  set distanceTravelled(double distanceTravelled) {
    _distanceTravelled = distanceTravelled;
    notifyListeners();
  }

  set userLocation(Position location) {
    _userLocation = location;
    notifyListeners();
  }

  StateModel() {
    _watch = Stopwatch();
  }

  void _onTick(Timer timer) {
    currentDuration = _watch.elapsed;
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
    currentDuration = _watch.elapsed;
    notifyListeners();
  }

  /// reset timer
  void reset() {
    stop();
    _watch.reset();
    currentDuration = Duration.zero;
    notifyListeners();
  }
}
