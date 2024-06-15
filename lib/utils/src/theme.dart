import 'package:flutter/material.dart';

class ThemeManager {
  final ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Colors.grey.shade300,
      primary: Colors.grey.shade200,
      secondary: Colors.grey.shade400,
      inversePrimary: Colors.grey.shade800,
    ),
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: Colors.grey.shade800,
          displayColor: Colors.black,
        ),
  );
  final ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      primary: Colors.grey.shade800,
      secondary: Colors.grey.shade700,
      inversePrimary: Colors.grey.shade300,
    ),
    textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.grey.shade300,
          displayColor: Colors.white,
        ),
  );
  ThemeManager();
}
