// splash_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nhameii/Page/home_page.dart';

import '../components/background.dart';
// import 'faq.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for 3 seconds then navigate
    Timer(const Duration(seconds: 3), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 117, height: 133),
              Stack(
                alignment: Alignment.center,
                children: [
                  // border layer with offset
                  Transform.translate(
                    offset: const Offset(5, 5),
                    child: Text(
                      'NhamEii',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Shooting Star',
                        foreground:
                            Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 10
                              ..color = const Color(0xFF410364),
                      ),
                    ),
                  ),
                  // Main border layer
                  Text(
                    'NhamEii',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Shooting Star',
                      foreground:
                          Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 10
                            ..color = const Color(0xFF410364),
                    ),
                  ),
                  // Fill layer
                  const Text(
                    'NhamEii',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Shooting Star',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
