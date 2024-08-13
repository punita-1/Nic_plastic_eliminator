import 'package:flutter/material.dart';

/// A notifier class for managing and notifying locale changes in the application.
/// It extends [ChangeNotifier] to enable listeners to be notified when the locale changes.
class LocaleNotifier with ChangeNotifier {
  /// The current locale of the application.
  Locale _locale = Locale('en');

  /// Gets the current locale.
  Locale get locale => _locale;

  /// Sets a new locale if it is different from the current one.
  /// Notifies listeners about the locale change.
  ///
  /// [newLocale] The new locale to be set.
  void setLocale(Locale newLocale) {
    if (_locale != newLocale) {
      _locale = newLocale;
      notifyListeners();
    }
  }
}
