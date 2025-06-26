import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;
  const PageTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 36, right: 22, left: 0),

      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3A015A),
          decoration: TextDecoration.none,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
