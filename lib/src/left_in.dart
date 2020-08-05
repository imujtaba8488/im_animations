import 'package:flutter/material.dart';

class LeftIn extends StatefulWidget {
  final double inValue;

  LeftIn({double inValue = 100.0}) : inValue = inValue;

  @override
  State<StatefulWidget> createState() {
    return LeftInState();
  }
}

class LeftInState extends State<LeftIn> with SingleTickerProviderStateMixin {
  AnimationController animation;

  @override
  void initState() {
    animation = AnimationController(
      duration: Duration(milliseconds: 10000),
      vsync: this,
      upperBound: widget.inValue,
    )..addListener(() {
        setState(() {});
      });

    animation.forward().orCancel;
    super.initState();
  }

  @override
  void didUpdateWidget(LeftIn oldWidget) {
    animation.reset();
    animation.forward().orCancel;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(animation.value, 0.0),
      child: Text('Mujtaba'),
    );
  }
}
