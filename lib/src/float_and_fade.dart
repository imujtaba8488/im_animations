import 'package:flutter/material.dart';

class FloatAndFade extends StatefulWidget {
  final Text text;

  FloatAndFade({@required this.text});

  @override
  _FloatAndFadeState createState() => _FloatAndFadeState();
}

class _FloatAndFadeState extends State<FloatAndFade>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation opacity;
  Animation move;

  double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              width: constraints.maxWidth,
              top: height / 2.0,
              child: widget.text,
            ),
            Positioned(
              top: move.value,
              width: constraints.maxWidth,
              child: Opacity(
                opacity: opacity.value,
                child: widget.text,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    height = widget.text.style.fontSize * 2;

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {});
      });

    opacity = Tween(begin: 1.0, end: 0.0).animate(controller);
    move = Tween(
      begin: height / 2.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.bounceOut,
      ),
    );

    controller.repeat();

    super.initState();
  }

  @override
  void didUpdateWidget(FloatAndFade oldWidget) {
    controller.reset();
    controller.forward();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
