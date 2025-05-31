import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String? text; // Now optional
  final VoidCallback onPressed;
  final double borderRadius;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;
  final String? imageAsset; // Changed from svgAsset to imageAsset
  final double iconSize;
  final bool iconOnRight;
  final double iconSpacing;

  const GradientButton({
    super.key,
    this.text, // optional now
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    this.borderRadius = 15.0,
    this.textStyle,
    this.width,
    this.height = 40,
    this.imageAsset,
    this.iconSize = 20,
    this.iconOnRight = false,
    this.iconSpacing = 8,
  });

  final Gradient _gradient = const LinearGradient(
    colors: [Color(0xFFFF69BE), Color(0xFFD8007A)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  Widget build(BuildContext context) {
    final style =
        textStyle ??
        const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        );

    Widget? icon =
        imageAsset != null
            ? Image.asset(
              imageAsset!,
              width: iconSize,
              height: iconSize,
              color: style.color, // Apply color tint if needed
            )
            : null;

    Widget? label =
        text != null
            ? Text(text!, style: style, textAlign: TextAlign.center)
            : null;

    List<Widget> content = [];

    if (icon != null && label != null) {
      content =
          iconOnRight
              ? [label, SizedBox(width: iconSpacing), icon]
              : [icon, SizedBox(width: iconSpacing), label];
    } else if (icon != null) {
      content = [icon];
    } else if (label != null) {
      content = [label];
    }

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          gradient: _gradient,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: content,
        ),
      ),
    );
  }
}
