import 'package:flutter/material.dart';

class ColorSonar extends StatefulWidget {
  /// The radius of the content area.
  final double contentAreaRadius;

  /// Determines how far the waves should fall away from the content area.
  final double waveFall;

  /// Determines the motion of waves while they fall away from the content area.
  final WaveMotion waveMotion;

  /// The effect to apply to the motion of waves while they fall away from the content area.
  final Curve waveMotionEffect;

  /// Determines how fast or slow the waves should transmit.
  final Duration duration;

  /// Whether the waves are disabled or not.
  final wavesDisabled;

  /// The background color of the content area.
  final Color contentAreaColor;

  /// The color of the inner most wave.
  final Color innerWaveColor;

  /// The color of the middle wave.
  final Color middleWaveColor;

  /// The color of the outer wave.
  final Color outerWaveColor;

  /// The widget to be placed inside the waves.
  final Widget child;

  ColorSonar({
    this.contentAreaRadius = 24.0,
    this.waveFall = 15.0,
    this.waveMotion = WaveMotion.synced,
    this.waveMotionEffect = Curves.easeOut,
    this.duration = const Duration(seconds: 1),
    this.wavesDisabled = false,
    this.contentAreaColor = Colors.white,
    this.innerWaveColor = const Color(0xFF696969),
    this.middleWaveColor = const Color(0xFFA9A9A9),
    this.outerWaveColor = const Color(0xFFDCDCDC),
    this.child,
  });

  @override
  _ColorSonarState createState() => _ColorSonarState();
}

class _ColorSonarState extends State<ColorSonar>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: _ColorSonarPainter(
          animationController: animationController,
          contentAreaRadius: widget.contentAreaRadius,
          waveFall: widget.waveFall,
          waveMotion: widget.waveMotion,
          waveMotionEffect: widget.waveMotionEffect,
          wavesDisabled: widget.wavesDisabled,
          contentAreaColor: Colors.white,
          innerWaveColor: widget.innerWaveColor,
          middleWaveColor: widget.middleWaveColor,
          outerWaveColor: widget.outerWaveColor,
        ),
        child: Center(
          child: widget?.child,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}

class _ColorSonarPainter extends CustomPainter {
  final AnimationController animationController;
  final double contentAreaRadius;
  final double waveFall;
  final bool wavesDisabled;
  final WaveMotion waveMotion;
  final Curve waveMotionEffect;

  final Color contentAreaColor;
  final Color innerWaveColor;
  final Color middleWaveColor;
  final Color outerWaveColor;

  Animation _innerWaveAnimation;
  Animation _middleWaveAnimation;
  Animation _outerWaveAnimation;

  _ColorSonarPainter({
    @required this.animationController,
    this.contentAreaRadius = 24.0,
    this.waveFall = 15.0,
    this.wavesDisabled = false,
    this.waveMotion = WaveMotion.synced,
    this.waveMotionEffect = Curves.easeOut,
    this.contentAreaColor = Colors.white,
    this.innerWaveColor = const Color(0xFF696969),
    this.middleWaveColor = const Color(0xFFA9A9A9),
    this.outerWaveColor = const Color(0xFFDCDCDC),
  }) {
    assert(
      contentAreaRadius >= 0.0,
      'Content Area Radius must be greater than or equal to 0.0',
    );
    assert(waveFall >= 0.0, 'Wave fall must be greater than or equal to 0.0');
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (!wavesDisabled) {
      initAnimations();

      // The draw order here matters.
      drawWave(canvas, size, _outerWaveAnimation.value, outerWaveColor);
      drawWave(canvas, size, _middleWaveAnimation.value, middleWaveColor);
      drawWave(canvas, size, _innerWaveAnimation.value, innerWaveColor);
    }

    // Must be drawn last.
    drawWave(canvas, size, contentAreaRadius, contentAreaColor);
  }

  void drawWave(Canvas canvas, Size size, double radius, Color color) {
    canvas.drawCircle(
      Offset(size.width / 2.0, size.height / 2.0),
      radius,
      Paint()..color = color,
    );
  }

  void initAnimations() {
    if (!wavesDisabled) animationController.repeat();

    double innerStart = contentAreaRadius;
    double innerEnd = innerStart + waveFall;
    double middleStart = innerEnd;
    double middleEnd = middleStart + waveFall;
    double outerStart = middleEnd;
    double outerEnd = outerStart + waveFall;

    _innerWaveAnimation = _createAnimation(
      begin: innerStart,
      end: innerEnd,
      interval: _innerWaveInterval,
    );

    _middleWaveAnimation = _createAnimation(
      begin: middleStart,
      end: middleEnd,
      interval: _middleWaveInterval,
    );

    _outerWaveAnimation = _createAnimation(
      begin: outerStart,
      end: outerEnd,
      interval: _outerWaveInterval,
    );
  }

  Interval get _innerWaveInterval {
    switch (waveMotion) {
      case WaveMotion.stepped:
        return Interval(0.0, 0.1, curve: waveMotionEffect);

      case WaveMotion.smooth:
        return Interval(0.0, 0.25, curve: waveMotionEffect);

      default:
        return Interval(0.0, 1.0, curve: waveMotionEffect);
    }
  }

  Interval get _middleWaveInterval {
    switch (waveMotion) {
      case WaveMotion.stepped:
        return Interval(0.4, 0.7, curve: waveMotionEffect);

      case WaveMotion.smooth:
        return Interval(0.25, 0.50, curve: waveMotionEffect);

      default:
        return Interval(0.0, 1.0, curve: waveMotionEffect);
    }
  }

  Interval get _outerWaveInterval {
    switch (waveMotion) {
      case WaveMotion.stepped:
        return Interval(0.8, 1.0, curve: waveMotionEffect);

      case WaveMotion.smooth:
        return Interval(0.50, 0.75, curve: waveMotionEffect);

      default:
        return Interval(0.0, 1.0, curve: waveMotionEffect);
    }
  }

  Animation _createAnimation({
    double begin = 0.0,
    double end = 1.0,
    Interval interval = const Interval(0.0, 1.0),
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        curve: interval,
        parent: animationController,
      ),
    );
  }

  @override
  bool shouldRepaint(_ColorSonarPainter oldDelegate) => true;
}

enum WaveMotion {
  smooth,
  stepped,
  synced,
}
