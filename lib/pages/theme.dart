import 'package:flutter/material.dart';

class AppTheme {
  static Color backgroundDark = Color(0xFF0F0F0F);
  static Color backgroundColor = Color(0xFF0F0F0F);
  static Color primaryColor = Color(0xFF9B5FFF);
  static Color accentColor = Color(0xFFC2A3FF);
  static Color textColor = Color(0xFFE4E4E7);
  static Color surfaceColor = Color(0xFF212121);
  static Color dividerColor = Color(0xFF2E2E2E);
  static Color errorColor = Color(0xFFCF6679);
  static Color borderColor = Color.fromRGBO(255, 255, 255, .18);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      dividerColor: dividerColor,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: primaryColor,
        surfaceContainerLowest: backgroundColor,
        surface: surfaceColor,
        onSurface: textColor,
        error: errorColor,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        titleTextStyle: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: 9,

          color: textColor
        ),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: textColor,
        )
      ),
    );
  }
}