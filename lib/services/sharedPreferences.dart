import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static late SharedPreferences _prefs;

  SharedPreferences get getPreferences => _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void saveString(String key, String value) async {
    _prefs.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static void saveInt(String key, int value) async {
    _prefs.setInt(key, value);
  }

  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  static void saveDouble(String key, double value) async {
    _prefs.setDouble(key, value);
  }

  static double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  static void saveBool(String key, bool value) async {
    _prefs.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }
}
