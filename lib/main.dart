import 'dart:math';
import 'package:flutter/material.dart';
import 'im_animations.dart';

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

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool changeAnim = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              changeAnim
                  ? HeartBeat(
                      child: const CircleAvatar(
                        radius: 48.0,
                        backgroundImage: AssetImage('assets/avatars/man.png'),
                      ),
                    )
                  : Rotate(
                      repeat: Random().nextBool(),
                      child: const CircleAvatar(
                        radius: 48.0,
                        backgroundImage: AssetImage('assets/avatars/man.png'),
                      ),
                    ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () => setState(() => changeAnim = !changeAnim),
                  child: const Text('Change animation')),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () => setState(
                        () {},
                      ),
                  child: const Text('Testing didUpdateWidget method'))
            ],
          ),
        ),
      ),
    );
  }
}
