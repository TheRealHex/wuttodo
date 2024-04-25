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
    primary: Color(0xff343434),
    secondary: Color(0xff343434),
    surface: Color(0xff4b4b4b),
    primaryContainer: Color(0xaaefefef),
  ),
  pageTransitionsTheme: pageTransitionSet(),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: appBarTheme,
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Color(0xffefefef),
    secondary: Color(0xffdedede),
    surface: Color(0xffd4d4d4),
    primaryContainer: Color(0xcc333333),
  ),
  pageTransitionsTheme: pageTransitionSet(),
);

PageTransitionsTheme pageTransitionSet() {
  return PageTransitionsTheme(builders: {
    TargetPlatform.android: NoAnimationPageTransitionsBuilder(),
    TargetPlatform.iOS: NoAnimationPageTransitionsBuilder(),
    TargetPlatform.linux: NoAnimationPageTransitionsBuilder(),
  });
}

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
