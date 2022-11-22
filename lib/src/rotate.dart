import 'dart:math';

import 'package:flutter/material.dart';

/// Defines the direction in which the rotation should take place.
enum RotationDirection {
  clockwise,
  anti_clockwise,
}

/// A widget which rotates its child(ren).
class Rotate extends StatefulWidget {
  /// The item to be rotated.
  final Widget? child;

  /// The number of rotations per minute. Defaults to 70.
  final int rotationsPerMinute;

  /// Whether to loop rotation or not.
  final bool repeat;

  /// The direction in which to rotate.
  final RotationDirection rotationDirection;

  Rotate({
    this.child,
    this.rotationsPerMinute = 70,
    this.repeat = false,
    this.rotationDirection = RotationDirection.clockwise,
  });

  @override
  State<StatefulWidget> createState() {
    return _RotateState();
  }
}

class _RotateState extends State<Rotate> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    // When it comes to calculating the rotations per minute. 60000 milliseconds which make up a minute is divided by the number of rotationsPerMinute. At the time of this writing, it approximately produces the desired effect. It is quite possible that this division might result in a negative number or 0, in that case a default rotation of 70rpm (857 milliseconds approx.) is applied.

    _animationController = AnimationController(
      duration: Duration(
        milliseconds: 60000 ~/ widget.rotationsPerMinute > 0
            ? 60000 ~/ widget.rotationsPerMinute
            : 857,
      ),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    animation = Tween(
            begin: widget.rotationDirection == RotationDirection.clockwise
                ? 0.0
                : pi * 2,
            end: widget.rotationDirection == RotationDirection.clockwise
                ? pi * 2
                : 0.0)
        .animate(_animationController);

    widget.repeat
        ? _animationController.repeat()
        : _animationController.forward();
  }

  @override
  void didUpdateWidget(Rotate oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animationController.reset();
    widget.repeat
        ? _animationController.repeat()
        : _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animation.value,
      child: Container(
        child: widget.child,
      ),
    );
  }
}
