import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:nduthi_gang/objects/state.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<StateModel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: MapBoxPlaceSearchWidget(
              popOnSelect: true,
              apiKey: provider.apiKey,
              limit: 10,
              onSelected: (place) {},
              context: context,
            ),
          ),
        ),
      ),
    );
  }
}
