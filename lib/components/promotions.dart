import 'package:flutter/material.dart';

class Promotions extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback? onTap;

  const Promotions({
    super.key,
    required this.imagePath,
    required this.label,
    this.onTap,
  }); 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Color(0xFFE9E9FF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                width: 32,
                height: 32,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF3A015A),
            ),
          ),
        ],
      ),
    );
  }
}
