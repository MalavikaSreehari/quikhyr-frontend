import 'package:flutter/material.dart';
import 'package:quikhyr/common/constants/app_colors.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: secondary,
        fontFamily: 'Trap',
        fontSize: 20,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w800,
        height: 1.0,
      ),
      headlineSmall: TextStyle(
        color: secondary,
        fontFamily: 'Trap',
        fontSize: 16,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 1.0,
      ),
      bodyLarge: TextStyle(
        color: secondary,
        fontFamily: 'Trap',
        fontSize: 13,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 1.0,
      ),
      bodyMedium: TextStyle(
        color: textColor,
        fontFamily: 'Trap',
        fontSize: 12,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 1.0,
      ),
    ),
    colorScheme: const ColorScheme(
      onError: error,
      surface: surface,
      onSurface: onSurface,
      brightness: Brightness.dark,
      background: background,
      onBackground: onBackground,
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onSecondary,
      tertiary: tertiary,
      error: error,
      outline: outline,
    ),
  );
}
