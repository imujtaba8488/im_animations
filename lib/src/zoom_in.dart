import 'package:flutter/cupertino.dart';

/// A widget which zooms-in it's child. The zoom-in effect can take place only once or can be set to repeat using the [repeat] property.
class ZoomIn extends StatefulWidget {
  /// The child to be zoomed-in.
  final Widget child;

  /// Controls how fast or slow the zoom-in effect should be.
  final int duration;

  /// Whether to indefinitely repeat the zoom-in effect or not.
  final bool repeat;

  ZoomIn({
    Widget child,
    int duration = 1000,
    bool repeat = false,
  })  : child = child,
        duration = duration,
        repeat = repeat;

  @override
  State<StatefulWidget> createState() {
    return _ZoomInState();
  }
}

class _ZoomInState extends State<ZoomIn> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    widget.repeat ? _controller.repeat() : _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ZoomIn oldWidget) {
    super.didUpdateWidget(oldWidget);

    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _animation.value,
      child: Container(
        child: widget.child,
      ),
    );
  }
}
