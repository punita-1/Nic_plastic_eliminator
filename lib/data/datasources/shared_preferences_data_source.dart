// ignore_for_file: depend_on_referenced_packages

import 'package:shared_preferences/shared_preferences.dart';

/// A helper class for managing user information and login state using SharedPreferences.
///
/// Provides methods to save, retrieve, and remove user data and login state.
class SharedPreferanceHelper {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userNameKey = 'userName';
  static const String _userEmailKey = 'userEmail';
  static const String _userImageKey = 'userImage';
  static const String _userIdKey = 'userId';

  /// Saves the login state of the user.
  ///
  /// Sets the login state to `true` in SharedPreferences under the key [_isLoggedInKey].
  Future<void> saveLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
  }

  /// Removes the login state of the user.
  ///
  /// Clears the login state from SharedPreferences by removing the key [_isLoggedInKey].
  Future<void> removeLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
  }

  /// Retrieves the current login state of the user.
  ///
  /// Returns `true` if the user is logged in, otherwise returns `false`.
  Future<bool> getLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  /// Saves the user's name.
  ///
  /// [userName] The name of the user to be saved.
  Future<void> saveUserName(String userName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, userName);
  }

  /// Saves the user's email.
  ///
  /// [userEmail] The email of the user to be saved.
  Future<void> saveUserEmail(String userEmail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userEmailKey, userEmail);
  }

  /// Saves the user's profile image URL.
  ///
  /// [userImage] The URL of the user's profile image to be saved.
  Future<void> saveUserImage(String userImage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userImageKey, userImage);
  }

  /// Retrieves the user's name.
  ///
  /// Returns the saved user's name, or `null` if not set.
  Future<String?> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  /// Retrieves the user's email.
  ///
  /// Returns the saved user's email, or `null` if not set.
  Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  /// Retrieves the URL of the user's profile image.
  ///
  /// Returns the saved profile image URL, or `null` if not set.
  Future<String?> getUserImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userImageKey);
  }

  /// Saves the user's ID.
  ///
  /// [id] The ID of the user to be saved.
  Future<void> saveUserId(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, id);
  }

  /// Clears all user-related information from SharedPreferences.
  ///
  /// Removes the user's name, email, profile image URL, and ID.
  Future<void> clearUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userNameKey);
    await prefs.remove(_userEmailKey);
    await prefs.remove(_userImageKey);
    await prefs.remove(_userIdKey);
  }
}
