import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nduthi_gang/blocs/state_widget.dart';
import 'package:nduthi_gang/objects/state.dart';
import 'package:nduthi_gang/ui/screens/home_screen_widgets.dart';
import 'package:nduthi_gang/ui/screens/search.dart';
import 'package:nduthi_gang/utils/bottom_navigation.dart';
import 'package:nduthi_gang/utils/colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  StateModel appState;
  StateWidgetState _bloc;
  GoogleMapController mapController;
  LatLng center;
  Geolocator location;
  StreamSubscription<Position> positionStream;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = StateWidget.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    positionStream.cancel();
    super.dispose();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _doManageTimer(StateModel provider) {
    if (!provider.isRunning) {
      provider.start();
    } else {
      provider.stop();
    }
  }

  @override
  void initState() {
    location = Geolocator();
    super.initState();
  }

  void setUpLocationListener(StateModel provider) {
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high);

    positionStream = location
        .getPositionStream(locationOptions)
        .listen((Position position) {});
    positionStream.onData((position) {
      if (provider.userLocation == null) {
        location
            .getCurrentPosition(
                desiredAccuracy: LocationAccuracy.bestForNavigation)
            .then((position) {
          provider.userLocation = position;
        });
      }

      var prevLocation = provider.userLocation;
      var newLocation = position;

      if (prevLocation.latitude != null) {
        // get distance travelled
        location
            .distanceBetween(prevLocation.latitude, prevLocation.longitude,
                newLocation.latitude, newLocation.longitude)
            .then((distance) {
          // set distance travelled
          provider.distanceTravelled = distance;
        });

        // set current location
        provider.userLocation = newLocation;

        // set current speed
        // provider.speed = position.speed;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = 120.0;
    var offset = width - 16;
    var provider = Provider.of<StateModel>(context);
    setUpLocationListener(provider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
              ),
            )
          ],
          title: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Text("Nduthi")),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              /// Map area
              Container(
                child: buildMapWidget(_bloc, provider),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.54,
              ),

              /// Distance Duration Speed container
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.198,
                color: colorSecondary,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          left: offset,
                          child: buildRoundedRect(width, "Duration", provider)),
                      Positioned(
                          left: offset * 2,
                          child: buildRoundedRect2(width, "Speed",
                              "${(provider.speed * 3.6).toStringAsFixed(1)} km/h")),
                      Positioned(
                          child: buildRoundedRect2(width, "Distance",
                              "${provider.distanceTravelled} m")),
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
                  onPressed: () {
                    _doManageTimer(provider);
                  },

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
