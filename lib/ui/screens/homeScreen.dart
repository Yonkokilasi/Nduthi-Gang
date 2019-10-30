import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nduthi_gang/bloc/state_widget.dart';
import 'package:nduthi_gang/objects/state.dart';
import 'package:nduthi_gang/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StateModel appState;
  StateWidgetState _bloc;

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
            Text('${appState.currentDuration}'),
            RaisedButton(
              onPressed: !appState.isRunning ? appState.start : appState.stop,
              child: Text(!appState.isRunning ? 'Start' : 'Stop'),
            ),
            RaisedButton(
              onPressed: appState.reset,
              child: Text('Reset'),
            )
          ],
        );
      },
    ));
  }

  Widget _buildRoundedRect() {
    return Container(
      width: 300,
      height: 300,
      margin: EdgeInsets.only(left: 40),
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Text("Duration"),
          _buildTimer(),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              Container(
                child: Text("Maps go here"),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                color: colorSecondary,
                child: Container(
                  child: Row(
                    children: <Widget>[
                      _buildRoundedRect(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
