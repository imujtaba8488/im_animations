import 'package:flutter/material.dart';

import 'im_animations.dart';
import 'src/color_sonar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'im_animations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

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
          child: const CircleAvatar(
            radius: 48.0,
            backgroundImage: AssetImage('assets/avatars/man.png'),
          ),
        ),
      ),
    );
  }
}
