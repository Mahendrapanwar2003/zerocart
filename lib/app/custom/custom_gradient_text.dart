
import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        Key? key,
        required this.gradient,
        this.style,
      }) : super(key: key);

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text,maxLines: 1, style: style),
    );
  }
}



class GradientIconColor extends StatelessWidget {
  const GradientIconColor(
      this.icon, {
        Key? key,
        required this.gradient,
         this.size=20
      }) : super(key: key);

  final IconData icon;
  final Gradient gradient;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Icon(icon,size: size),
    );
  }
}