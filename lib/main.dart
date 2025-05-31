import 'package:flutter/material.dart';

import 'splashscreen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          titleMedium: TextStyle(color: Color(0xFF3E0061), fontSize: 18),
          headlineSmall: TextStyle(color: Color(0xFF3E0061), fontSize: 24),
          bodyMedium: TextStyle(color: Color(0xFF3E0061), fontSize: 14),
        ),
      ),

      home: const SplashScreen(), // Start with splash screen
    );
  }
}
