import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({Key? key, required this.child}) : super(key: key);

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
      child: child,
    );
  }
}
