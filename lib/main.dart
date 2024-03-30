import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/theme_model.dart';
import 'data/boxes.dart';
import 'data/textdata.dart';
import 'screen/about.dart';
import 'screen/completed.dart';
import 'screen/home.dart';
import 'theme/theme_constants.dart';

void main() async {
  // init hive
  await Hive.initFlutter();

  // register the adapter
  Hive.registerAdapter(TextDataAdapter());
  // Hive.registerAdapter(ThemeDarkAdapter());
  Hive.registerAdapter(ThemeModelAdapter());

  // open box
  boxTodo = await Hive.openBox<TextData>('todoBox');
  boxTheme = await Hive.openBox<ThemeModel>('themeBox');

  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => Home(toggleTheme: toggleTheme),
        '/checked': (_) => Checked(),
        '/about': (_) => About(),
      },
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeManager.isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }

  void toggleTheme() {
    setState(() {
      // update isDark on Hive
      ThemeManager.toggleTheme(!ThemeManager.isDarkMode);
    });
  }
}
