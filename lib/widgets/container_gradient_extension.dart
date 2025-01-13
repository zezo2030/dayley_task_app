import 'package:flutter/material.dart';

extension ContainerGradientExtension on Container {
  Container addLinearGradient({
    List<Color> colors = const [Colors.blue, Colors.purple],
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    double radius = 10,
  }) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: begin,
            end: end,
          ),
          borderRadius: BorderRadius.circular(radius)),
      child: child,
    );
  }

  Container addRadialGradient({
    List<Color> colors = const [Colors.blue, Colors.purple],
    double radius = 0.5,
    AlignmentGeometry center = Alignment.center,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: colors,
          radius: radius,
          center: center,
        ),
      ),
      child: child,
    );
  }

  Container addSweepGradient({
    List<Color> colors = const [Colors.blue, Colors.purple],
    AlignmentGeometry center = Alignment.center,
    double startAngle = 0.0,
    double endAngle = 3.14159 * 2,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: SweepGradient(
          colors: colors,
          center: center,
          startAngle: startAngle,
          endAngle: endAngle,
        ),
      ),
      child: child,
    );
  }
}
