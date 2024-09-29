import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: 'IBM Plex Sans Arabic',
  scaffoldBackgroundColor: const Color.fromRGBO(240, 240, 240, 1), // default background color of Scaffold
  colorScheme: const ColorScheme.light(
    surface: Color.fromRGBO(240, 240, 240, 1),           // Background of Scaffold
    surfaceContainer: Color.fromRGBO(255, 255, 255, 1),  // Background of Container that setted on Scaffold
    primary: Color.fromARGB(255, 217, 4, 39),            // Red color (from design) (Main color)
    primaryContainer: Color.fromARGB(255, 223, 12, 47),  // Variant of Red color (if needed)
    secondary: Color.fromARGB(255, 43, 45, 66),          // Dark blue color (from design) (Secondary color)
    secondaryContainer: Color.fromARGB(255, 92, 99, 120),// Variant of Dark blue color (if needed)
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 255, 255, 255),  // Background of AppBar - dont change
  ),
);
