import 'package:flutter/material.dart';

import 'package:im_animations/im_animations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'im_animations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  "Rotate",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: Sonar(
                  radius: 100,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/avatars/man.png'),
                    radius: 100,
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

//---------------------COLOR SONAR------------------------------//
class ColorSonarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ColorSonar(
          // wavesDisabled: true,
          // waveMotion: WaveMotion.synced,
          contentAreaRadius: 48.0,
          waveFall: 15.0,
          // waveMotionEffect: Curves.elasticIn,
          waveMotion: WaveMotion.synced,
          // duration: Duration(seconds: 5),
          child: CircleAvatar(
            radius: 48.0,
            backgroundImage: AssetImage('assets/avatars/man.png'),
          ),
        ),
      ),
    );
  }
}
