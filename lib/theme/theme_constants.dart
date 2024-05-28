import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../data/theme_model.dart';
import '../style.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: appBarTheme,
  colorScheme: ColorScheme.dark(
    onSurface: Colors.black,
    primary: Color(0xffefefef),
    surface: Color(0xffd4d4d4),
    primaryContainer: Color(0xcc333333),
    secondaryContainer: Color(0xff232323),
  ),
  pageTransitionsTheme: pageTransitionSet(),
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: appBarTheme,
  colorScheme: ColorScheme.light(
    onSurface: Colors.white,
    primary: Color(0xff343434),
    surface: Color(0xff4b4b4b),
    primaryContainer: Color(0xaaefefef),
    secondaryContainer: Color(0xffefefef),
    // secondaryContainer: Colors.white,
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

class ThemeManager {
  static Box<ThemeModel> _themeBox = Hive.box<ThemeModel>('themeBox');

  static bool get isDarkMode => _themeBox.get(0)?.isDark ?? false;

  static Future<void> toggleTheme(bool isDark) async {
    await _themeBox.put(0, ThemeModel(isDark: isDark));
  }
}
