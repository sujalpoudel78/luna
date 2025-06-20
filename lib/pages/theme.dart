import 'package:flutter/material.dart';

class AppTheme {
  // Dark Theme - Amoled
  static Color backgroundDark = Color(0xff000000);
  static Color backgroundColor = Color(0xFF000000); // Pure black for AMOLED
  static Color primaryColor = Color(0xFF9B5FFF); // Soft purple
  static Color accentColor = Color(0xFFC2A3FF); // Light lavender tone
  static Color textColor = Color(0xFFE4E4E7); // Light gray text
  static Color surfaceColor = Color(0xFF212121); //Lighter
  static Color dividerColor = Color(0xFF2E2E2E); // Divider lines
  static Color errorColor = Color(0xFFCF6679); // Error
  static Color borderColor = Color.fromRGBO(255, 255, 255, .27);

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
          fontSize: 27,
          fontWeight: FontWeight.w700,
          letterSpacing: 9,

          color: textColor
        ),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 27,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}