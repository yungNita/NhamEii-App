import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFCED0FD), // #CED0FD
            Color(0xFFEADCF4), // #EADCF4
            Color(0xFFF9DEEA), // #F9DEEA
          ], 
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.49, 1.0],
        ),
      ),
      child: child,
    );
  }
}
