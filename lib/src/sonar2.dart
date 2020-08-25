import 'package:flutter/material.dart';

class Sonar2 extends StatefulWidget {
  @override
  _Sonar2State createState() => _Sonar2State();
}

class _Sonar2State extends State<Sonar2> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation1;
  Animation animation2;
  Animation animation3;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: Sonar2Painter(animation1, animation2, animation3),
        child: Center(
          child: Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {});
      });

    animation1 = Tween(begin: 24.0, end: 30.0).animate(
      CurvedAnimation(
        curve: Interval(
          0.0,
          0.25,
        ),
        parent: animationController,
      ),
    );

    animation2 = Tween(begin: 30.0, end: 40.0).animate(
      CurvedAnimation(
        curve: Interval(
          0.25,
          0.5,
        ),
        parent: animationController,
      ),
    );

    animation3 = Tween(begin: 40.0, end: 50.0).animate(
      CurvedAnimation(
        curve: Interval(
          0.5,
          0.75,
        ),
        parent: animationController,
      ),
    );

    animationController.repeat();
  }
}

class Sonar2Painter extends CustomPainter {
  Animation animation1;
  Animation animation2;
  Animation animation3;

  Sonar2Painter(
    this.animation1,
    this.animation2,
    this.animation3,
  );

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(size.width / 2.0, size.height / 2.0),
      animation3.value,
      Paint()
        ..color = Colors.blueGrey[100]
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      Offset(size.width / 2.0, size.height / 2.0),
      animation2.value,
      Paint()
        ..color = Colors.blueGrey[500]
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      Offset(size.width / 2.0, size.height / 2.0),
      animation1.value,
      Paint()
        ..color = Colors.blueGrey[900]
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(Sonar2Painter oldDelegate) => true;
}
