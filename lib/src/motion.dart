import 'package:flutter/material.dart';

class Motion extends StatefulWidget {
  final Move move;
  final Widget child;
  final int duration;

  Motion({Widget child, int duration = 1000, Move move})
      : move = move,
        duration = duration,
        child = child;

  @override
  State<StatefulWidget> createState() {
    return MotionState();
  }
}

class MotionState extends State<Motion> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    controller.forward().orCancel;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Motion oldWidget) {
    controller.reset();
    controller.forward().orCancel;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: createAnimation(widget.move),
      child: widget.child,
    );
  }

  Offset createAnimation(Move move) {
    Animation animation = Tween(begin: 0.0, end: move.distance).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          move.timeSlot.startTime,
          move.timeSlot.endTime,
        ),
      ),
    );

    return Offset(
      move.axis == MoveAxis.x ? animation.value : 0.0,
      move.axis == MoveAxis.y ? animation.value : 0.0,
    );
  }
}

class Move {
  double distance;
  MoveAxis axis;
  TimeSlot timeSlot;

  Move(this.distance, this.axis, this.timeSlot);
}

enum MoveAxis {
  x,
  y,
}

class TimeSlot {
  double startTime, endTime;

  TimeSlot(this.startTime, this.endTime);
}
