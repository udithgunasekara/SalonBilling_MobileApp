import 'package:flutter/material.dart';
import 'package:salon_mobile/assets/theme/themecolor.dart';

class ThemeButton extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final double borderRadius;
  final String text;
  final VoidCallback onPressed;
  final TextStyle textStyle;

  const ThemeButton({
    Key? key,
    this.height = 70, // Default height
    this.width = double.infinity, // Default width
    this.color = mainColor, // Default color
    this.borderRadius = 20, // Default border radius
    required this.text,
    required this.onPressed,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w500,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
