import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;

  const CustomText({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF3A015A),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
