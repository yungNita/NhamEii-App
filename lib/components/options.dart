import 'package:flutter/material.dart';

import 'button.dart';

class Options extends StatelessWidget {
  final String title;
  final String buttonText;
  final String imageAsset;
  final String image;
  final VoidCallback onPressed;
  final bool imageLeft;

  const Options({
    super.key,
    required this.title,
    required this.buttonText,
    required this.imageAsset,
    required this.image,
    required this.onPressed,
    this.imageLeft = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 16),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: const Color(0xFFE9E9FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                children:
                    imageLeft
                        ? [const SizedBox(width: 10), _buildTextAndButton()]
                        : [_buildTextAndButton()],
              ),
              Positioned(
                left: imageLeft ? -30 : null,
                right: imageLeft ? null : -30,
                bottom: -10,
                child: Image.asset(
                  image,
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextAndButton() {
    return Expanded(
      child: Column(
        crossAxisAlignment:
            imageLeft ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: imageLeft ? Alignment.centerRight : Alignment.centerLeft,
            child: GradientButton(
              width: 90,
              onPressed: onPressed,
              imageAsset: imageAsset,
              text: buttonText,
              textStyle: const TextStyle(fontSize: 13, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
