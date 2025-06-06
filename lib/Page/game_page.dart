import 'package:flutter/material.dart';
import '../components/nav_wrapper.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavWrapper(
      currentIndex: 1, // 🕹 Index for 'Game'
      child: Center(
        child: Text('Game Page'),
      ),
    );
  }
}
