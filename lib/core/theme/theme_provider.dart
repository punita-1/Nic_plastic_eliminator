import 'package:flutter/material.dart';

/// Provides theme management for the application.
///
/// This class extends [ChangeNotifier] to allow listeners to be notified
/// when the theme mode changes. It supports toggling between light and dark themes.
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode;

  /// Creates a [ThemeProvider] with an optional initial [ThemeMode].
  ///
  /// By default, the initial theme mode is set to [ThemeMode.light].
  ThemeProvider({ThemeMode initialThemeMode = ThemeMode.light})
      : _themeMode = initialThemeMode;

  /// Gets the current [ThemeMode].
  ThemeMode get themeMode => _themeMode;

  /// Toggles between light and dark themes.
  ///
  /// If the current theme mode is light, it switches to dark.
  /// If the current theme mode is dark, it switches to light.
  /// Notifies listeners of the change.
  void toggleTheme() {
    _themeMode =
        (_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notify listeners about the theme change
  }
}
