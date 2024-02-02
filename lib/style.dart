import 'package:flutter/material.dart';

AppBarTheme appBarTheme = AppBarTheme(
  centerTitle: true,
);

TextStyle appBarTextStyle(BuildContext context) {
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: Theme.of(context).colorScheme.primary,
  );
}
