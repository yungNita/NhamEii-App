// components/back_button_widget.dart
import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: Color(0xFF3E0061),
        size: 30,
      ),
      onPressed: () {
        Navigator.pop(context); // Pops to previous screen
      }, 
    );
  }
}
