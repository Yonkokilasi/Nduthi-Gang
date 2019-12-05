import 'package:flutter/material.dart';

Widget bottomNav() {
  return BottomAppBar(
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.history),
          ),
        ],
      ),
    ),
    notchMargin: 8,
    shape: CircularNotchedRectangle(),
  );
}
