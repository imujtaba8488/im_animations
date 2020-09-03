import 'package:flutter/material.dart';
import 'package:im_animations/src/color_sonar.dart';
import 'package:im_animations/src/float_and_fade.dart';
import 'package:im_animations/src/text_animator.dart';
import 'package:im_animations/src/tighten.dart';

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
    return Scaffold();
  }
}
