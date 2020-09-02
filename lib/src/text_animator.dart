import 'package:flutter/material.dart';

class TextAnimator extends StatefulWidget {
  final Text text;

  TextAnimator(this.text);

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
    return Center(
      child: Text(
        displayText,
        style: widget.text.style,
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
      end: widget.text.data.length,
    ).animate(controller)
      ..addListener(() {
        /// It is essentail that displayText is recreated everytime, rather than concatenated.
        displayText = widget.text.data.substring(0, animation.value);
      });
  }
}
