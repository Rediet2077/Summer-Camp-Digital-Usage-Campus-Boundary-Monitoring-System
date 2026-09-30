import 'package:flutter/material.dart';

class AppTheme {
  // Primary Colors - From Mockups
  static const Color primaryColor = Color(0xFF4C9EFF); // Bright Blue (from login button)
  static const Color secondaryColor = Color(0xFF2D7DD2); // Medium Blue
  static const Color accentColor = Color(0xFF7CB3FF); // Light Blue
  
  // Background Colors
  static const Color lightBackground = Color(0xFFF5F7FA); // Light Grey/White from mockups
  static const Color cardBackground = Color(0xFFFFFFFF); // Pure White for cards
  static const Color darkBackground = Color(0xFF0F172A); // Very Dark Blue (for dark mode)
  static const Color darkCardBackground = Color(0xFF1E293B); // Dark Blue Grey (for dark mode)
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1A202C); // Dark text
  static const Color textSecondary = Color(0xFF718096); // Grey text
  static const Color textWhite = Color(0xFFFFFFFF); // White text
  static const Color textDark = Color(0xFF1E293B);
  
  // Status Colors - From Mockups
  static const Color successColor = Color(0xFF34C759); // Green (Inside Camp)
  static const Color warningColor = Color(0xFFFFCC00); // Yellow (warnings)
  static const Color errorColor = Color(0xFFFF3B30); // Red (Outside Camp)
  static const Color infoColor = Color(0xFF007AFF); // Blue (info/education)
  
  // Chart Colors - From Mockups
  static const Color chartEducation = Color(0xFF007AFF); // Blue
  static const Color chartProductivity = Color(0xFF5856D6); // Purple
  static const Color chartSocialMedia = Color(0xFFFF2D55); // Pink/Red
  static const Color chartEntertainment = Color(0xFFFF9500); // Orange
  static const Color chartGaming = Color(0xFFFF6B35); // Deep Orange
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
  
  // Light Theme - Main theme from mockups
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
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
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
