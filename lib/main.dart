import 'package:flutter/material.dart';
import 'package:im_animations/src/color_sonar.dart';
import 'package:im_animations/src/text_animator.dart';

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
        child: TextAnimator(
          Text(
            '7006106521',
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ),
    );
  }
}
