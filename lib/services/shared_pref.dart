import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferanceHelper {
  static const String _isLoggedInKey = 'isLoggedIn';

  Future<void> saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
  }

  Future<void> removeLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
  }

  Future<bool> getLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> saveUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
  }

  Future<void> saveUserEmail(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', userEmail);
  }

  Future<void> saveUserImage(String userImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userImage', userImage);
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail');
  }

  Future<String?> getUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userImage');
  }

  Future<void> saveUserId(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', id);
  }

  Future<void> clearUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userName');
    await prefs.remove('userEmail');
    await prefs.remove('userImage');
    await prefs.remove('userId');
  }
}
