import 'package:flutter/material.dart';
import 'package:nduthi_gang/ui/screens/homeScreen.dart';

class Nduthi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nduthi",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => HomeScreen()},
    );
  }
}
