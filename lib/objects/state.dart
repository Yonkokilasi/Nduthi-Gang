import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/material.dart';

class StateModel with ChangeNotifier {
  Stopwatch _watch;
  Timer _timer;
  bool locationPermissions ;
  LocationData userLocation;
  Duration currentDuration = Duration.zero;

 bool get isRunning => _timer != null;
 
  StateModel() {
    _watch = Stopwatch();
    locationPermissions = false;
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
