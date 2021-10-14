import 'package:flutter/material.dart';

/// Controls the fade effect.
enum FadeEffect {
  fadeIn,
  fadeOut,
}

/// A widget which fades its child(ren) based on the [FadeEffect].
class Fade extends StatefulWidget {
  /// The item to fade.
  final Widget? child;

  /// The duration of the [fadeEffect].
  final Duration duration;

  /// Whether to fade-in or fade-out.
  final FadeEffect fadeEffect;

  Fade({
    this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.fadeEffect = FadeEffect.fadeIn,
  });

  @override
  State<StatefulWidget> createState() {
    return _FadeState();
  }
}

class _FadeState extends State<Fade> with SingleTickerProviderStateMixin {
  late AnimationController _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeAnimation = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    widget.fadeEffect == FadeEffect.fadeIn
        ? _fadeAnimation.forward(from: 0.0).orCancel
        : _fadeAnimation.reverse(from: 1.0).orCancel;
  }

  @override
  void didUpdateWidget(Fade oldWidget) {
    _fadeAnimation.reset();

    widget.fadeEffect == FadeEffect.fadeIn
        ? _fadeAnimation.forward(from: 0.0).orCancel
        : _fadeAnimation.reverse(from: 1.0).orCancel;

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _fadeAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _fadeAnimation.value,
      child: widget.child,
    );
  }
}
