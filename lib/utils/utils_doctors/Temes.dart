import 'dart:ui';

import 'package:flutter/material.dart';

class LightColors {
  static const Color dark = Color(0xFF1E1E1E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray = Color(0xFFE8E8E8);
  static const Color white1 = Color.fromARGB(255, 126, 126, 126);
  static const Color blue = Color(0xFF3B7BC7);
  static const Color blue2 = Color(0xFF0B50A4);
  static const Color blue1 = Color(0xFF0000FF);
  static const Color green = Color.fromARGB(255, 2, 246, 50);
  static const Color red = Color.fromARGB(255, 249, 7, 7);
}

class DarkColors {
  static const Color dark = Color(0xFF121212);
  static const Color white = Color(0xFF1E1E1E);
  static const Color white1 = Color.fromARGB(255, 180, 180, 180);
  static const Color blue = Color(0xFF1A237E);
  static const Color blue1 = Color(0xFF2196F3);
  static const Color blue2 = Color(0xFF0B50A4);
  static const Color gray = Color(0xFF424242);
  static const Color red = Color.fromARGB(255, 94, 1, 19);
  static const Color green = Color.fromARGB(255, 2, 130, 50);
}

class ThemeManager {
  static bool _darkMode = false;

  static bool get darkMode => _darkMode;

  static void toggleDarkMode() {
    _darkMode = !_darkMode;
  }

  static Color get dark => _darkMode ? DarkColors.dark : LightColors.dark;
  static Color get white => _darkMode ? DarkColors.white : LightColors.white;
  static Color get gray => _darkMode ? DarkColors.gray : LightColors.gray;
  static Color get white1 => _darkMode ? DarkColors.white1 : LightColors.white1;
  static Color get blue => _darkMode ? DarkColors.blue : LightColors.blue;
  static Color get blue2 => _darkMode ? DarkColors.blue2 : LightColors.blue2;
  static Color get blue1 => _darkMode ? DarkColors.blue1 : LightColors.blue1;
  static Color get green => _darkMode ? DarkColors.green : LightColors.green;
  static Color get red => _darkMode ? DarkColors.red : LightColors.red;
}
