import 'package:flutter/material.dart';

class Cursor extends StatefulWidget {
  final Widget child;

  Cursor({@required this.child});

  @override
  _CursorState createState() => _CursorState();
}

class _CursorState extends State<Cursor> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation cursor;

  @override
  Widget build(BuildContext context) {
    if (cursor.isDismissed) {
      controller.forward();
    } else if (cursor.isCompleted) {
      controller.reverse();
    }

    return Opacity(
      opacity: cursor.value,
      child: widget.child,
    );
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });

    cursor = Tween(begin: 0.0, end: 1.0).animate(controller);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
