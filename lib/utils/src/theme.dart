import 'package:flutter/material.dart';

class ThemeManager {
  final ThemeData lightMode = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Colors.grey.shade300,
      primary: Colors.grey.shade200,
      secondary: Colors.grey.shade400,
      surface: Colors.grey.shade100,
      onBackground: Colors.grey.shade800,
      onPrimary: Colors.grey.shade800,
      onSecondary: Colors.grey.shade800,
      onSurface: Colors.grey.shade800,
    ),
    textTheme: Typography.blackMountainView
        .apply(
          bodyColor: Colors.grey.shade800,
          displayColor: Colors.black,
        )
        .copyWith(
          bodyText2: TextStyle(
            color: Colors.grey.shade800, // Darker text for body text
          ),
          bodyText1: TextStyle(
            color: Colors.grey.shade800, // Darker text for body text
          ),
        ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Colors.grey.shade400, // Customize your button color here
        foregroundColor: Colors.grey.shade800, // Text color
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor:
            Colors.grey.shade600, // Customize your text button color here
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor:
            Colors.grey.shade600, // Customize your outlined button color here
        side: BorderSide(color: Colors.grey.shade600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),
      filled: true,
      fillColor: Colors.grey.shade100,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.grey.shade500,
      selectionColor: Colors.grey.shade400.withOpacity(0.3),
      selectionHandleColor: Colors.grey.shade800,
    ),
  );

  final ThemeData darkMode = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      primary: Colors.grey.shade800,
      secondary: Colors.grey.shade700,
      surface: Colors.grey.shade800,
      onBackground: Colors.grey.shade300,
      onPrimary: Colors.grey.shade300,
      onSecondary: Colors.grey.shade300,
      onSurface: Colors.grey.shade300,
    ),
    textTheme: Typography.whiteMountainView
        .apply(
          bodyColor: Colors.grey.shade300,
          displayColor: Colors.white,
        )
        .copyWith(
          bodyMedium: TextStyle(
            color: Colors.grey.shade300, // Lighter text for body text
          ),
          bodyLarge: TextStyle(
            color: Colors.grey.shade300, // Lighter text for body text
          ),
        ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Colors.grey.shade700, // Customize your button color here
        foregroundColor: Colors.grey.shade300, // Text color
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor:
            Colors.grey.shade500, // Customize your text button color here
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor:
            Colors.grey.shade500, // Customize your outlined button color here
        side: BorderSide(color: Colors.grey.shade500),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade500),
      ),
      filled: true,
      fillColor: Colors.grey.shade800,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.grey.shade500,
      selectionColor: Colors.grey.shade700.withOpacity(0.3),
      selectionHandleColor: Colors.grey.shade300,
    ),
  );

  ThemeManager();
}
