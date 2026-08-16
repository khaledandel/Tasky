import 'package:flutter/material.dart';
import 'package:tasky/Screens/main_screen.dart';
import 'package:tasky/Screens/welcome_screen.dart';
import 'package:tasky/core/services/preferences_manager.dart';
// ignore: unused_import
import 'package:tasky/core/themes/dark_mode.dart';
// ignore: unused_import
import 'package:tasky/core/themes/light_mode.dart';
import 'package:tasky/core/themes/theme_controlar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferanceManager().inti();
  String? username = PreferanceManager().getString('username');
  ThemeControlar().inti();
  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeControlar.themeNotifier,
      builder: (BuildContext context, valueThemeMode, Widget? child) {
        return MaterialApp(
          title: 'To Do App',

          theme: lightMode,
          darkTheme: darkMode,
          themeMode: valueThemeMode,
          debugShowCheckedModeBanner: false,
          home: username == null ? Welcome_Screen() : MainScreen(),
        );
      },
    );
  }
}
