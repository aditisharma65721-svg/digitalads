import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double borderRadius;
  final double fontSize;
  final double height;
  final double width;
  final Color textColor;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.pink, // default color
    this.borderRadius = 12,
    this.fontSize = 16,
    this.height = 50,
    this.width = double.infinity,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
        ),
      ),
    );
  }
}


class CommonButtonWithIcon extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
 
  final Color backgroundColor;
  final double borderRadius;
  final double fontSize;
  final double height;
  final double width;
  final Color textColor;
  final double iconSize;
  final Color? iconColor;

  const CommonButtonWithIcon({
    super.key,
    required this.text,
    required this.onPressed,
    
    this.backgroundColor = Colors.pinkAccent,
    this.borderRadius = 12,
    this.fontSize = 16,
    this.height = 50,
    this.width = double.infinity,
    this.textColor = Colors.white,
    this.iconSize = 20,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
              ),
            ),
            SizedBox(width: 8),
            Image.asset(
              "assets/icons/nextArrow.png",
              height: iconSize,
              color: iconColor ?? textColor,
            ),
          ],
        ),
      ),
    );
  }
}
