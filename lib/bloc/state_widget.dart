import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nduthi_gang/objects/state.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if (widget.state != null) {
      state = widget.state;
    } else {
      state = new StateModel();
    }
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
