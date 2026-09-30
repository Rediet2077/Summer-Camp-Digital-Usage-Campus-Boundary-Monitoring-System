import 'package:flutter/material.dart';
import 'constants/app_theme.dart';

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
      themeMode: ThemeMode.dark, // Default to dark theme as per design
      home: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
