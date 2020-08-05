import 'package:flutter/cupertino.dart';

class ZoomIn extends StatefulWidget {
  final Widget child;
  final int duration;
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
    return ZoomInState();
  }
}

class ZoomInState extends State<ZoomIn> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: widget.duration), vsync: this)
      ..addListener(() {
        setState(() {});
      });

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );

    widget.repeat ? controller.repeat() : controller.forward().orCancel;

    // Since an animation could be stopped unexpectedly (e.g. the screen is
    // dismissed), when using one of these APIs, it is safer to add the
    // “.orCancel“. Thanks to this little trick, no exception will be thrown if
    // the Ticker is cancelled before the controller is disposed.
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ZoomIn oldWidget) {
    controller.reset();
    controller.forward().orCancel;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animation.value,
      child: Container(
        child: widget.child,
      ),
    );
  }
}
