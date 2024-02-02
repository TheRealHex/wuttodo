import 'package:flutter/material.dart';
import 'package:todo_app/style.dart';

// bool isDark = false;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: appBarTheme,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.grey[850]!,
    secondary: Colors.grey[800]!,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: appBarTheme,
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.grey[300]!,
    secondary: Colors.grey[350]!,
  ),
);
