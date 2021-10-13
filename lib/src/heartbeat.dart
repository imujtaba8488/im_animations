import 'package:flutter/material.dart';

/// A widget which adds a heartbeat effect to its contents.
class HeartBeat extends StatefulWidget {
  /// The item to apply the heartbeat effect to.
  final Widget? child;

  /// The number of beats per minutes. Defaults to 70.
  final int beatsPerMinute;

  HeartBeat({this.child, this.beatsPerMinute = 70}) {
    assert(beatsPerMinute > 0, 'beatsPerMinute must be greater than 0.');
  }

  @override
  State<StatefulWidget> createState() {
    return _HeartBeatState();
  }
}

class _HeartBeatState extends State<HeartBeat>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _beatForward, _beatBackward;

  @override
  void initState() {
    super.initState();

    // When it comes to calculating the beats per minute. 60000 milliseconds which make up a minute is divided by the number of beatsPerMinute. At the time of this writing it approximately produces the desired effect. It is quite possible that this division might result in a negative number or 0, in that case a default beating of 70bps (857 milliseconds) is applied.

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 60000 ~/ widget.beatsPerMinute > 0
            ? 60000 ~/ widget.beatsPerMinute
            : 857,
      ),
    )..addListener(() {
        setState(() {});
      });

    // Equivalent to zooming in the child at the specified interval.
    _beatForward = Tween(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.30,
          0.65,
          curve: Curves.easeIn,
        ),
      ),
    );

    // Equivalent to zooming out the child at the specified interval.
    _beatBackward = Tween(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.65,
          1.00,
          curve: Curves.easeIn,
        ),
      ),
    );

    // Since a heartbeat, so repeats infinitely.
    _controller.repeat().orCancel;
  }

  @override
  void didUpdateWidget(HeartBeat oldWidget) {
    _controller.reset();
    _controller.repeat().orCancel;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // First scale up, then scale down.
    return Transform.scale(
      scale: _beatForward.value,
      child: Transform.scale(
        scale: _beatBackward.value,
        child: widget.child,
      ),
    );
  }
}
