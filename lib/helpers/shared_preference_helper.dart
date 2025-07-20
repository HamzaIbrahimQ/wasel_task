import 'package:shared_preferences/shared_preferences.dart';

/// This class for all shared preference transactions
class SharedPreferenceHelper {
  static Future<void> saveIntValue({String? key, int? value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key ?? '', value ?? 0);
  }

  static Future<int?> getIntValue({String? key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key ?? '');
  }

  static Future<void> saveBooleanValue({required String key, required bool value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key ?? '', value ?? false);
  }

  static Future<bool?> getBooleanValue({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? boolValue = prefs.getBool(key);
    return boolValue;
  }

  static Future<void> saveStringValue({String? key, String? value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key ?? '', value ?? '');
  }

  static Future<String> getStringValue({String? key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String stringValue = prefs.getString(key ?? '') ?? '';
    return stringValue;
  }

  static Future<void> deleteValue({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
