import 'package:flutter/material.dart';

class AppFontSizes {
  static const double base = 16;
  static const double small = 14;
  static const double tiny = 12;
  static const double large = 18;
  static const double extraLarge = 20;
}

class AppTextStyles {
  // Base (default: 16)
  static TextStyle base({Color color = Colors.black}) => TextStyle(
    fontSize: AppFontSizes.base,
    fontWeight: FontWeight.w400,
    color: color,
  );

  static TextStyle baseBold({Color color = Colors.black}) => TextStyle(
    fontSize: AppFontSizes.base,
    fontWeight: FontWeight.w400,
    color: color,
  );

  ///
  ///
  ///New Chnges. ......

  static TextStyle baseBoldExtra({Color color = Colors.black}) => TextStyle(
    fontSize: AppFontSizes.extraLarge,
    fontWeight: FontWeight.bold,
    color: color,
  );

  static TextStyle baseBoldExtraContiner({Color color = Colors.black}) =>
      TextStyle(
        fontSize: AppFontSizes.base,
        fontWeight: FontWeight.bold,
        color: color,
      );

  ////

  // Small (default: 14)
  static TextStyle small({Color color = Colors.black}) => TextStyle(
    fontSize: AppFontSizes.small,
    fontWeight: FontWeight.w400,
    color: color,
  );

  static TextStyle smallBold({Color color = Colors.black}) => TextStyle(
    fontSize: AppFontSizes.small,
    fontWeight: FontWeight.w600,
    color: color,
  );

  // Tiny (default: 12)
  static TextStyle tiny({Color color = Colors.black}) => TextStyle(
    fontSize: AppFontSizes.tiny,
    fontWeight: FontWeight.w400,
    color: color,
  );

  // Large (default: 18)
  static TextStyle large({Color color = Colors.black}) => TextStyle(
    fontSize: AppFontSizes.large,
    fontWeight: FontWeight.w600,
    color: color,
  );

  // Extra Large (default: 20)
  static TextStyle extraLarge({Color color = Colors.black}) => TextStyle(
    fontSize: AppFontSizes.extraLarge,
    fontWeight: FontWeight.w600,
    color: color,
  );
}
