import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';

class ThemeService extends DependencyChangeNotifier {
  ThemeMode _mode = ThemeMode.dark;
  ThemeMode get mode => _mode;

  void toggleThemeMode() {
    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
    } else {
      _mode = ThemeMode.dark;
    }
    notifyListeners();
  }

  bool get isDarkMode => _mode == ThemeMode.dark;
  bool get isLightMode => _mode == ThemeMode.light;
}
