import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  const CustomRefreshIndicator(
      {
        Key? key,
        required this.gradient,
        required this.child,
        required this.onRefresh,
      }) : super(key: key);

  final Widget child;
  final Gradient gradient;
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: RefreshIndicator(onRefresh: onRefresh,
      child: child,),
    );
  }
}