import 'dart:ui';
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
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: false, 
      body: Stack(
        children: [
          child,
          if (!isKeyboardOpen)
            Positioned(
              bottom: 20,
              left: 12,
              right: 12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: AnimatedOpacity(
                    opacity: isKeyboardOpen ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 200),
                    child: SafeArea(
                      bottom: true,
                      child: NavBar(
                        currentIndex: currentIndex,
                        onTap: (index) => _onTap(context, index),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
