import 'package:flutter/material.dart';

import '../button.dart';

// import '../button.dart' show GradientButton;
// import 'package:nhameii/components/button.dart' show GradientButton;



class FilterButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  const FilterButton({
    super.key,
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return GradientButton(
        text: label,
        onPressed: onPressed,
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        borderRadius: 20,
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      );
    } else {
      return GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 36,
          padding: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xFFD8007A)),
            color: Colors.transparent,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFFD8007A),
              fontWeight: FontWeight.w700,
            ),
          ),
          
        ),
      );
    }
  }
}
