// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ThemeInit {
  static ThemeData? theme = ThemeData(
    useMaterial3: true,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: Color.fromARGB(255, 42, 35, 77),
      ),
      bodyMedium: TextStyle(
        color: Color.fromARGB(255, 42, 35, 77),
      ),
    ),
  );
}
