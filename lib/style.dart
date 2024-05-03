import 'package:flutter/material.dart';

AppBarTheme appBarTheme = AppBarTheme(
  centerTitle: true,
);

TextStyle appBarTextStyle(BuildContext context) {
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 17.6,
    color: Theme.of(context).colorScheme.surface,
    fontFamily: 'Montserrat',
  );
}

TextStyle contentTextStyle(BuildContext context) {
  return TextStyle(
    color: Theme.of(context).colorScheme.surface,
    fontWeight: FontWeight.w600,
    fontSize: 13.5,
    wordSpacing: 0.7,
    letterSpacing: 0.6,
    fontFamily: 'Montserrat',
  );
}

TextStyle labelTextStyle(BuildContext context) {
  return TextStyle(
    color: Theme.of(context).colorScheme.surface,
    fontWeight: FontWeight.w600,
    fontSize: 13,
    wordSpacing: 0.7,
    letterSpacing: 0.6,
    fontFamily: 'Montserrat',
  );
}
