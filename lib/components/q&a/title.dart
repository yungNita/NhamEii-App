import 'package:flutter/material.dart';
import 'package:nhameii/components/backbutton.dart';

class PageTitle extends StatelessWidget {
  final String title;
  const PageTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BackButtonWidget(),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3A015A),
            decoration: TextDecoration.none,
            fontFamily: 'Poppins'
          ),
        ),
      ],
    );
  }
}
