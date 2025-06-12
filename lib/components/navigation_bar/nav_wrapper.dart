import 'package:flutter/material.dart';
import 'nav_bar.dart';

class NavWrapper extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const NavWrapper({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    final routes = ['/home', '/game', '/qa', '/history', '/account'];
    Navigator.pushReplacementNamed(context, routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          child,
          Positioned(
            bottom: 20,
            left: 12,
            right: 12,
            child: NavBar(
              currentIndex: currentIndex,
              onTap: (index) => _onTap(context, index),
              
              
            ),
          ),
        ],
      ),
    );
  }
}
