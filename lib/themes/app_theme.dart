import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.teal;
  static const Color accent = Colors.tealAccent;

  static ThemeData baseTheme = ThemeData.light().copyWith(
    primaryColor: primary,

    //appBar Theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
    ),
  );
}
