import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  SharedPreferences? preferences;
  static final UserSimplePreferences _instance = UserSimplePreferences._();

  UserSimplePreferences._() {
    _init();
  }

  factory UserSimplePreferences() {
    return _instance;
  }

  static const _keyUsername = "username";
  static const _keyPassword = "password";

  Future<void> _init() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<void> setUsername(String username) async {
    await _init();
    preferences!.setString(_keyUsername, username);
  }

  Future<String?> getUsername() async {
    await _init();
    return preferences!.getString(_keyUsername);
  }

  Future<void> setPassword(String password) async {
    await _init();
    preferences!.setString(_keyPassword, password);
  }

  Future<String?> getPassword() async {
    await _init();
    return preferences!.getString(_keyPassword);
  }
}
