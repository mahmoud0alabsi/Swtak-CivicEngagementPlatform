import 'package:flutter/material.dart';


// ================== Dark Theme ==================
// ===============Dont change anything===============

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: 'IBM Plex Sans Arabic',
  scaffoldBackgroundColor: const Color.fromARGB(255, 33, 35, 51),
  colorScheme: const ColorScheme.dark(
    surface: Color.fromARGB(255, 33, 35, 51),
    surfaceContainer: Color.fromARGB(255, 43, 45, 66),
    primary: Color.fromARGB(255, 255, 255, 255),
    secondary: Color.fromARGB(255, 217, 4, 39),
    secondaryContainer: Color.fromARGB(255, 223, 12, 47),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 43, 45, 66),
  ),
);
