import 'package:flutter/material.dart';

import 'components/background.dart';
import 'components/button.dart';
import 'components/promotions.dart';
import 'components/text.dart';

class TestComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Background(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Optional: Add padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align items to the left (optional)
                mainAxisSize: MainAxisSize.max, // Take full height
                children: [
                  CustomText(text: 'Hello, there'),
                  SizedBox(height: 20),
                  GradientButton(
                    text: 'Press Me',
                    onPressed: () {},
                    width: 100,
                  ),
                  SizedBox(height: 20),
                  Promotions(
                    imagePath: 'images/download.jpg',
                    label: 'Promotions',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
