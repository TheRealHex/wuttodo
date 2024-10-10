import 'package:flutter/material.dart';

AppBarTheme appBarTheme = const AppBarTheme(
  centerTitle: true,
);

TextStyle appBarTextStyle(BuildContext context) {
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 17,
    color: Theme.of(context).colorScheme.surface,
    fontFamily: 'Montserrat',
  );
}

TextStyle contentTextStyle(BuildContext context) {
  return TextStyle(
    color: Theme.of(context).colorScheme.surface,
    fontWeight: FontWeight.w600,
    fontSize: 13,
    wordSpacing: 0.5,
    letterSpacing: 0.5,
    fontFamily: 'Montserrat',
  );
}

TextStyle labelTextStyle(BuildContext context) {
  return TextStyle(
    color: Theme.of(context).colorScheme.surface,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    wordSpacing: 0.7,
    letterSpacing: 0.6,
    fontFamily: 'Montserrat',
  );
}
