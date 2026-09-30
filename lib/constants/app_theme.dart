import 'package:flutter/material.dart';

class AppTheme {
  // Primary Colors - Ochre + Forest Premium Theme
  static const Color primaryColor = Color(0xFFA66A00); // Ochre
  static const Color secondaryColor = Color(0xFF18352B); // Forest Dark
  static const Color accentColor = Color(0xFFD5B65A); // Light Ochre/Gold
  
  // Background Colors
  static const Color lightBackground = Color(0xFFF5F1E6); // Cream background
  static const Color cardBackground = Color(0xFFFFFFFF); // Pure White for cards
  static const Color darkBackground = Color(0xFF18352B); // Forest Dark (for dark mode)
  static const Color darkCardBackground = Color(0xFF1E3A30); // Slightly lighter forest
  
  // Text Colors
  static const Color textPrimary = Color(0xFF20251F); // Dark text
  static const Color textSecondary = Color(0xFF6B7069); // Grey text
  static const Color textWhite = Color(0xFFFFFFFF); // White text
  static const Color textDark = Color(0xFF18352B); // Forest dark
  
  // Border Colors
  static const Color borderColor = Color(0xFFDED8C8); // Light border
  
  // Status Colors - Adapted to theme
  static const Color successColor = Color(0xFF2D5F3F); // Forest green
  static const Color warningColor = Color(0xFFD5B65A); // Gold/Accent
  static const Color errorColor = Color(0xFFC1440E); // Rust/Orange-Red
  static const Color infoColor = Color(0xFFA66A00); // Ochre
  
  // Chart Colors - Earthy palette
  static const Color chartEducation = Color(0xFFA66A00); // Ochre
  static const Color chartProductivity = Color(0xFF18352B); // Forest Dark
  static const Color chartSocialMedia = Color(0xFFD5B65A); // Light Gold
  static const Color chartEntertainment = Color(0xFF8B5A2B); // Brown
  static const Color chartGaming = Color(0xFF4A6741); // Olive Green
  static const Color chartOther = Color(0xFF8E8E93); // Grey
  
  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: darkCardBackground,
      error: errorColor,
    ),
    cardTheme: CardThemeData(
      color: darkCardBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackground,
      elevation: 0,
      iconTheme: IconThemeData(color: textWhite),
      titleTextStyle: TextStyle(
        color: textWhite,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: textWhite,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkCardBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      hintStyle: const TextStyle(color: textSecondary, fontSize: 14),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: textWhite,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: textWhite,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        color: textWhite,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: textWhite,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: textWhite,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: textWhite,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: textWhite,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: textSecondary,
        fontSize: 14,
      ),
      labelLarge: TextStyle(
        color: textWhite,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
  
  // Light Theme - Main theme with Ochre + Forest palette
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: lightBackground,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: cardBackground,
      error: errorColor,
    ),
    cardTheme: CardThemeData(
      color: cardBackground,
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: lightBackground,
      elevation: 0,
      iconTheme: IconThemeData(color: textPrimary),
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: textWhite,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      hintStyle: const TextStyle(color: textSecondary, fontSize: 14),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: textPrimary,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: textPrimary,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        color: textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: textPrimary,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: textSecondary,
        fontSize: 14,
      ),
      labelLarge: TextStyle(
        color: textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
