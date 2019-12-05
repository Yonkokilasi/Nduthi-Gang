import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nduthi_gang/blocs/state_widget.dart';
import 'package:nduthi_gang/objects/state.dart';
import 'package:nduthi_gang/ui/screens/home_screen.dart';
import 'package:nduthi_gang/utils/colors.dart';

  Widget buildRoundedRect(double width, String text,StateModel appState) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11.0),
      ),
      child: Container(
        width: width,
        height: 70,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text("$text"),
            buildTimer(appState),
          ],
        ),
      ),
    );
  }

Widget buildTimer(StateModel appState) {
  return Center(
      child: AnimatedBuilder(
    animation: appState, // listen to ChangeNotifier
    builder: (context, child) {
      // this part is rebuilt whenever notifyListeners() is called
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${appState.currentDuration}',
            style: TextStyle(fontSize: 11),
          ),
        ],
      );
    },
  ));
}

Widget buildMapWidget(StateWidgetState _bloc) {
  LatLng _center;
  _bloc.askPermissions();

  // build based on permissions check
  return FutureBuilder<bool>(
      future: _bloc.checkPermissionStatus(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.hasData != null) {
          /// we have location permissions
          var showUserLocation = snapshot.data;
          return FutureBuilder<LocationData>(
              future: _bloc.getUserLocation(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done ||
                    snapshot.hasData && snapshot.data != null) {
                  var lat = snapshot.data.latitude;
                  var long = snapshot.data.longitude;

                  // get user's location
                  if (lat != null && long != null) {
                    /// set initial position based on user's position
                    _center = LatLng(lat, long);
                  }

                  /// load google maps
                  return GoogleMap(
                    myLocationButtonEnabled: showUserLocation,
                    myLocationEnabled: showUserLocation,
                    trafficEnabled: true,
                    compassEnabled: true,
                    onMapCreated: HomeScreenState().onMapCreated,
                    initialCameraPosition:
                        CameraPosition(target: _center, zoom: 14.0),
                  );
                } else {
                  return SpinKitDoubleBounce(
                    color: colorPrimary,
                    size: 60,
                  );
                }
              });
        } else {
          return GoogleMap(
            trafficEnabled: true,
            compassEnabled: true,
            onMapCreated: HomeScreenState().onMapCreated,
            initialCameraPosition: CameraPosition(
                target: LatLng(-1.2855928, 36.8191551), zoom: 14.0),
          );
        }
      });
}
