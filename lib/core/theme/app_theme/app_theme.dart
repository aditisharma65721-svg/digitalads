import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color borderColor = Color(0xFFDEDEDE);

double textFieldRadius = 10;

class AppLightTheme {
  static OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: borderColor),
    borderRadius: BorderRadius.all(Radius.circular(textFieldRadius)),
  );

  static OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: Colors.red),
    borderRadius: BorderRadius.all(Radius.circular(textFieldRadius)),
  );

  static OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: borderColor),
    borderRadius: BorderRadius.all(Radius.circular(textFieldRadius)),
  );

  static OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: borderColor),
    borderRadius: BorderRadius.all(Radius.circular(textFieldRadius)),
  );

  static ThemeData getLightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      primaryColor: Colors.white,
      cardTheme: CardThemeData(
        surfaceTintColor: Colors.white,
        color: Colors.white,
      ),
      textTheme: GoogleFonts.urbanistTextTheme(),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
      appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      // inputDecorationTheme: InputDecorationTheme(
      //   contentPadding: const EdgeInsets.fromLTRB(20, 16, 10, 12),
      //   filled: true,
      //   fillColor: Color(0xFFDEDEDE),
      //   enabledBorder: enabledBorder,
      //   focusedBorder: enabledBorder,
      //   errorBorder: enabledBorder,
      //   border: border,
      //   labelStyle: TextStyle(fontSize: 12),
      // ),
    );
  }
}
