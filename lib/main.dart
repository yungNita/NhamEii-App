import 'package:flutter/material.dart';
import 'package:nhameii/Page/account_section/account_page.dart';
import 'package:nhameii/router/app_router.dart';

// import 'Page/home_page.dart';
// import 'Page/splashscreen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

      home: const MyAccountPage(), // Start with splash screen
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
