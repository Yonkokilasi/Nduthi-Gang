import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 64.0, horizontal: 32.0),
              color: Colors.greenAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new AssetImage(
                                      "assets/account_profile.jpg")))),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('UserName'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Icon(Icons.directions_bike),
                                    Text('1'),
                                    Text('Motorcycle(s)')
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Icon(Icons.timer),
                                    Text('10h 20m'),
                                    Text('Total Time')
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Icon(Icons.golf_course),
                                    Text('20'),
                                    Text('Total Rides')
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Image.asset('assets/account_motorcycle.jpg', fit: BoxFit.fill),
            ),
          ],
        ),
      ),
    );
  }
}
