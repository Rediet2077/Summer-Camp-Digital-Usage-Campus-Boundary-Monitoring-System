import 'package:flutter/material.dart';
import 'constants/app_theme.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const CampGuardApp());
}

class CampGuardApp extends StatelessWidget {
  const CampGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampGuard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // Light theme as per mockups
      home: const WelcomeScreen(),
    );
  }
}
