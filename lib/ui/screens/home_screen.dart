import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nduthi_gang/blocs/state_widget.dart';
import 'package:nduthi_gang/objects/state.dart';
import 'package:nduthi_gang/ui/screens/home_screen_widgets.dart';
import 'package:nduthi_gang/utils/bottom_navigation.dart';
import 'package:nduthi_gang/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  StateModel appState;
  StateWidgetState _bloc;
  GoogleMapController mapController;
  LatLng center;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = StateWidget.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _doManageTimer() {
    if (!appState.isRunning) {
      appState.start();
    } else {
      appState.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = 120.0;
    var offset = width - 16;
    appState = StateWidget.of(context).state;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Nduthi"),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              /// Map area
              Container(
                child: buildMapWidget(_bloc),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.57,
              ),

              /// Distance Duration Speed container
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.198,
                color: colorSecondary,
                child: Container(
                  margin: EdgeInsets.only(top: 30, left: 30),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          left: offset,
                          child: buildRoundedRect(width, "Duration", appState)),
                      // Positioned(
                      //     left: offset * 2,
                      //     child: buildRoundedRect(width, "Speed", appState)),
                      // Positioned(
                      //     child: buildRoundedRect(width, "Distance", appState)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: bottomNav(),
        floatingActionButton: Container(
          height: 77.0,
          width: 77.0,
          child: FittedBox(
            child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: colorPrimary,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: IconButton(
                  onPressed: _doManageTimer,

                  /// to do replace with custom
                  icon: Icon(Icons.motorcycle),
                )),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
