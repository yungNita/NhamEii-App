import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double borderRadius;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;
  final String? svgAsset; // Optional SVG asset path
  final double svgSize; // Size of the SVG icon

  const GradientButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    this.borderRadius = 15.0,
    this.textStyle,
    this.width,
    this.height = 50,
    this.svgAsset,
    this.svgSize = 20,
  }) : super(key: key);

  final Gradient _gradient = const LinearGradient(
    colors: [Color(0xFFFF69BE), Color(0xFFD8007A)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  Widget build(BuildContext context) {
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
        child:
            svgAsset == null
                ? Text(
                  text,
                  style:
                      textStyle ??
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                  textAlign: TextAlign.center,
                )
                : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      svgAsset!,
                      width: svgSize,
                      height: svgSize,
                      color: textStyle?.color ?? Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      text,
                      style:
                          textStyle ??
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
      ),
    );
  }
}
