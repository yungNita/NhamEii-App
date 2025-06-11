import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFCED0FD), Color(0xFFEADCF4), Color(0xFFF9DEEA)],
        ),
      ),
      child: SafeArea(
        child: Material(
          color: Colors.transparent, 
          child: child,
        ),
      ),
    );
  }
}