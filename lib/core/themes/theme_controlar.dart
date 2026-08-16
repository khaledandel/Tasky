import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';

class ThemeControlar {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(.dark);

  inti() {
    bool result = PreferanceManager().getBool('theme') ?? true;
    themeNotifier.value = result ? .dark : .light;
  }

  static toggleTheme() async {
    if (themeNotifier.value == .dark) {
      themeNotifier.value = .light;
      await PreferanceManager().setBool('theme', false);
    } else {
      themeNotifier.value = .dark;
      await PreferanceManager().setBool('theme', true);
    }
  }

  static bool isDark() => themeNotifier.value == ThemeMode.dark;
}
