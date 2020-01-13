import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nduthi_gang/objects/state.dart';
import 'package:nduthi_gang/ui/screens/home_screen_widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

class StateWidget extends StatefulWidget {
  final StateModel state;
  final Widget child;

  StateWidget({@required this.child, this.state});

  static StateWidgetState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_StateDataWidget)
            as _StateDataWidget)
        .data;
  }

  @override
  State<StatefulWidget> createState() => new StateWidgetState();
}

class StateWidgetState extends State<StateWidget> {
  StateModel state;

  @override
  void dispose() {
    Wakelock.disable();
    state.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Wakelock.enable();
    askPermissions();
    if (widget.state != null) {
      state = widget.state;
    } else {
      state = new StateModel();
    }
  }

  Future<void> askPermissions() async {
    await PermissionHandler()
        .requestPermissions([PermissionGroup.locationAlways]);
        await checkPermissionStatus();
  }

  Future<bool> checkPermissionStatus() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationAlways);
    switch (permission) {
      case PermissionStatus.denied:
        {
          createToast("Permission needed to continue");
          askPermissions();
          return false;
        }
        break;
      case PermissionStatus.granted:
        {
          state.locationPermissions = true;

          return true;
        }
        break;

      default:
        {
          return false;
        }
    }
  }

  Future<Position> getUserLocation() async {
    state.userLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   
    return state.userLocation;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StateModel>(
      builder: (BuildContext context) => StateModel(),
      child: new _StateDataWidget(
        data: this,
        child: widget.child,
      ),
    );
  }
}

class _StateDataWidget extends InheritedWidget {
  final StateWidgetState data;

  _StateDataWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_StateDataWidget oldWidget) => true;
}
