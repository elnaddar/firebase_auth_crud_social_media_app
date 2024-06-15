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
          bodyMedium: TextStyle(
            color: Colors.grey.shade800, // Darker text for body text
          ),
          bodyLarge: TextStyle(
            color: Colors.grey.shade800, // Darker text for body text
          ),
        ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.grey.shade300; // Custom pressed color
            } else if (states.contains(MaterialState.hovered)) {
              return Colors.grey.shade300; // Custom hover color
            } else if (states.contains(MaterialState.disabled)) {
              return Colors.grey.shade100; // Custom disabled color
            }
            return Colors.white; // Default color
          },
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
            Colors.grey.shade800), // Text color
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.white
                  .withOpacity(0.2); // Custom hover overlay color
            } else if (states.contains(MaterialState.pressed)) {
              return Colors.white
                  .withOpacity(0.2); // Custom pressed overlay color
            } else if (states.contains(MaterialState.disabled)) {
              return Colors.grey.shade100
                  .withOpacity(0.2); // Custom disabled overlay color
            }
            return null; // Default overlay color
          },
        ),
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
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.grey.shade700; // Custom pressed color
            } else if (states.contains(MaterialState.hovered)) {
              return Colors.grey.shade700; // Custom hover color
            } else if (states.contains(MaterialState.disabled)) {
              return Colors.grey.shade100; // Custom disabled color
            }
            return Colors.grey.shade800; // Default color
          },
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
            Colors.grey.shade200), // Text color
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.grey.shade300
                  .withOpacity(0.2); // Custom hover overlay color
            } else if (states.contains(MaterialState.pressed)) {
              return Colors.grey.shade300
                  .withOpacity(0.2); // Custom pressed overlay color
            } else if (states.contains(MaterialState.disabled)) {
              return Colors.grey.shade100
                  .withOpacity(0.2); // Custom disabled overlay color
            }
            return null; // Default overlay color
          },
        ),
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
