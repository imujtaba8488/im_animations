import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:im_animations/src/float_and_fade.dart';

import 'cursor.dart';

class TextAnimator extends StatefulWidget {
  final String text;
  final TextStyle style;

  TextAnimator(this.text, {this.style});

  @override
  _TextAnimatorState createState() => _TextAnimatorState();
}

class _TextAnimatorState extends State<TextAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation animation;

  String displayText = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: FloatAndFade(
          text: Text(
            displayText,
            style: widget?.style,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    )..addListener(() {
        setState(() {});
      });

    initTypedAnimation();

    controller.forward();
    // cursorController.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TextAnimator oldWidget) {
    // initTypedAnimation();
    // resetAnimation();
    super.didUpdateWidget(oldWidget);
  }

  void resetAnimation() {
    controller.reset();
    controller.forward();
  }

  void initTypedAnimation() {
    animation = IntTween(
      begin: 0,
      end: widget.text.length,
    ).animate(controller)
      ..addListener(() {
        /// It is essentail that displayText is recreated everytime, rather than concatenated.
        displayText = widget.text.substring(0, animation.value);
      });
  }
}

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      // ..moveTo(0.0, size.height)
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0.0)
      ..lineTo(0.0, 0.0);

    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.blue
        // ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
