import 'package:flutter/material.dart';

extension GradientMask on Widget {
  Widget redToBlueGradientMask() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.red, Colors.blue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: this,
    );
  }

  Widget grayToBlackGradientMask() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color.fromARGB(255, 158, 158, 158), Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: this,
    );
  }
}
