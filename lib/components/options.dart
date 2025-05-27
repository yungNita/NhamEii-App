import 'package:flutter/material.dart';

import 'button.dart';

class Options extends StatelessWidget {
  final String title;
  final String buttonText;
  final String imageAsset;
  final VoidCallback onPressed;

  const Options({
    super.key,
    required this.title,
    required this.buttonText,
    required this.imageAsset,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358,
      height: 81,
      decoration: BoxDecoration(
        color: const Color(0xFFE9E9FF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GradientButton(
                      onPressed: onPressed,
                      imageAsset: imageAsset,
                      text: buttonText,
                      textStyle: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: -20,
              bottom: -10,
              child: Image.asset(
                'assets/images/peng.png',
                width: 116,
                height: 116,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
