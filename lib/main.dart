import 'package:flutter/material.dart';
import 'package:im_animations/src/color_sonar.dart';

import 'im_animations.dart';

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
