import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nduthi_gang/bloc/state_widget.dart';
import 'package:nduthi_gang/objects/state.dart';
import 'package:nduthi_gang/utils/bottomNavigation.dart';
import 'package:nduthi_gang/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StateModel appState;
  StateWidgetState _bloc;
  GoogleMapController mapController;
  final LatLng _center = const LatLng(-1.2855928, 36.8191551);

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

  Widget _buildTimer() {
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
            Visibility(
              visible: false,
              child: RaisedButton(
                onPressed: !appState.isRunning ? appState.start : appState.stop,
                child: Text(!appState.isRunning ? 'Start' : 'Stop'),
              ),
            ),
            Visibility(
              visible: false,
              child: RaisedButton(
                onPressed: appState.reset,
                child: Text('Reset'),
              ),
            )
          ],
        );
      },
    ));
  }

  Widget _buildRoundedRect(double width, String text) {
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
            _buildTimer(),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget _buildMapWidget() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(target: _center, zoom: 14.0),
    );
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
                child: _buildMapWidget(),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.58,
              ),

              /// Distance Duration Speed container
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.199,
                color: colorSecondary,
                child: Container(
                  margin: EdgeInsets.only(top: 30, left: 20),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          left: offset,
                          child: _buildRoundedRect(width, "Duration")),
                      Positioned(
                          left: offset * 2,
                          child: _buildRoundedRect(width, "Speed")),
                      Positioned(child: _buildRoundedRect(width, "Distance")),
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
                  onPressed: () {},

                  /// to do replace with custom
                  icon: new Icon(Icons.motorcycle),
                )),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
