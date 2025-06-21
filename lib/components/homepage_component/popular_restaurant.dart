import 'package:flutter/material.dart';

class PopularRestaurant extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback? onTap;

  const PopularRestaurant({
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
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3A015A),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}