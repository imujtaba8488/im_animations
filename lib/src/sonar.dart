import 'package:flutter/material.dart';

/// A widget which repeatedly displays sonar wave pattern around its child widget. __Note:__ Dimensions of the child widget depend on the [radius] of the Sonar widget.
class Sonar extends StatefulWidget {
  /// The radius of the sonar widget, including its waves.
  final double radius;

  /// The child to be placed inside the waves.
  final Widget child;

  /// The thickness of sonar waves.
  final double waveThickness;

  /// The color of sonar waves.
  final Color waveColor;

  /// Determines how fast or slow the sonar waves should transmit.
  final Duration duration;

  /// Padding around the child widget. __Note:__ The value of the insets is applied evenly on each side of the child widget.
  final double insets;

  /// Disables the waves.
  final wavesDisabled;

  Sonar({
    this.radius = 24.0,
    @required this.child,
    this.waveThickness = 0.5,
    this.waveColor = Colors.blue,
    this.duration = const Duration(seconds: 1),
    this.insets = 0.0,
    this.wavesDisabled = false,
  }) {
    assert(radius > 0, 'radius must be greater than 0');
    assert(insets >= 0, 'insets must be greater than or equal to 0');
    assert(
      waveThickness >= 0.0,
      'waveThickness must be greater than or equal to 0.0',
    );
  }

  @override
  _SonarState createState() => _SonarState();
}

class _SonarState extends State<Sonar> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() {
        setState(() {});
      });

    if (!widget.wavesDisabled) _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If insets are applied radius takes that into consideration. This needs to be ascertained at the begining of every build.
    double radius = widget.radius + (widget.insets * 4);

    return Container(
      // Margin around the CustomPaint ensures that the waves do not overflow out of the drawing area. Note: insets is multiplied by 4 because the insets are applied evenly around the 4 sides of the child widget.
      margin: EdgeInsets.all((widget.radius + widget.insets * 4) / 3.0),

      child: CustomPaint(
        painter: _WavePainter(
          _controller,
          strokeWidth: widget.waveThickness,
          strokeColor: widget.waveColor,
        ),
        child: Container(
          // The amount of padding around the child is determined by the insets.
          padding: EdgeInsets.all(widget.insets),
          height: radius,
          width: radius,
          child: Center(
            child: widget?.child,
          ),
        ),
      ),
    );
  }
}

/// Paints the sonar waves.
class _WavePainter extends CustomPainter {
  final AnimationController controller;
  final double strokeWidth;
  final Color strokeColor;

  _WavePainter(
    this.controller, {
    this.strokeWidth = 0.5,
    this.strokeColor = Colors.black,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Animation wave1 = Tween(
      begin: (size.width / 5.0) + (size.height / 5.0),
      end: (size.width / 3.5) + (size.height / 3.5),
    ).animate(controller);

    Animation wave2 = Tween(
      begin: (size.width / 5.0) + (size.height / 5.0),
      end: (size.width / 3.0) + (size.height / 3.0),
    ).animate(controller);

    Animation wave3 = Tween(
      begin: (size.width / 5.0) + (size.height / 5.0),
      end: (size.width / 2.5) + (size.height / 2.5),
    ).animate(controller);

    _drawWave(canvas, size, wave1);
    _drawWave(canvas, size, wave2);
    _drawWave(canvas, size, wave3);
  }

  /// Draws a wave with the given radius.
  void _drawWave(Canvas canvas, Size size, Animation radius) {
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius.value,
      Paint()
        ..color = strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
