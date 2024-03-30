import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../data/theme_model.dart';
import '../style.dart';

class ThemeManager {
  static Box<ThemeModel> _themeBox = Hive.box<ThemeModel>('themeBox');

  static bool get isDarkMode => _themeBox.get(0)?.isDark ?? false;

  static Future<void> toggleTheme(bool isDark) async {
    await _themeBox.put(0, ThemeModel(isDark: isDark));
  }
}

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: appBarTheme,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.grey[850]!,
    secondary: Colors.grey[800]!,
  ),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: NoAnimationPageTransitionsBuilder(),
    TargetPlatform.iOS: NoAnimationPageTransitionsBuilder(),
    TargetPlatform.linux: NoAnimationPageTransitionsBuilder(),
  }),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: appBarTheme,
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.grey[300]!,
    secondary: Colors.grey[350]!,
  ),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: NoAnimationPageTransitionsBuilder(),
    TargetPlatform.iOS: NoAnimationPageTransitionsBuilder(),
    TargetPlatform.linux: NoAnimationPageTransitionsBuilder(),
  }),
);

// No animation in transition
class NoAnimationPageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // No animation, simply return the child
    return child;
  }
}
