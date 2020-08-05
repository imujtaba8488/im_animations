import 'package:flutter/material.dart';

class Jump extends StatefulWidget {
  final Widget child;
  final int cyclesPerMinute;
  final bool repeat;

  Jump({
    this.child,
    this.cyclesPerMinute = 70,
    this.repeat = false,
  }) {
    assert(cyclesPerMinute > 0, 'beatsPerMinute must be greater than 0.');
  }

  @override
  State<StatefulWidget> createState() {
    return JumpState();
  }
}

class JumpState extends State<Jump> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _jumpUpAnimation;
  Animation<double> _jumpDownAnimation;

  @override
  void initState() {
    // When it comes to calculating the beats per minute. 60000 milliseconds which make up a minute is divided by the number of beatsPerMinute. At the time of this writing it approximately produces the desired effect. It is quite possible that this division might result in a negative number or 0, in that case a default beating of 70bps (857 milliseconds) is applied.

    _controller = AnimationController(
      duration: Duration(
        milliseconds: 60000 ~/ widget.cyclesPerMinute > 0
            ? 60000 ~/ widget.cyclesPerMinute
            : 857,
      ),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _jumpUpAnimation = Tween(
      begin: 20.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          .50,
        ),
      ),
    );

    _jumpDownAnimation = Tween(
      begin: 0.0,
      end: 20.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.50,
          1.0,
        ),
      ),
    );

    widget.repeat
        ? _controller.repeat().orCancel
        : _controller.forward().orCancel;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Jump oldWidget) {
    _controller.reset();
    _controller.forward().orCancel;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // The problem here is that extra spaces are added toward the upper end
    // of this animated widget. How to take care it?
    return Transform.translate(
      offset: Offset(
        0.0,
        _jumpUpAnimation.value,
      ),
      child: Transform.translate(
        offset: Offset(0.0, _jumpDownAnimation.value),
        child: widget.child,
      ),
    );
  }
}
