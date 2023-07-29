import 'package:flutter/material.dart';

class DecoratedButton extends StatelessWidget {
  final String buttonText;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;

  const DecoratedButton({
    required this.buttonText,
    required this.onPressed,
    this.icon,
    this.buttonColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.borderWidth = 2.0,
    this.borderColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        onPrimary: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(width: borderWidth, color: borderColor),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon),
          if (icon != null) SizedBox(width: 8.0),
          Text(buttonText),
        ],
      ),
    );
  }
}
