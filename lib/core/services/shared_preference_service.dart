import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  late Future<SharedPreferences> sharedPreferences;

  SharedPrefService() {
    this.sharedPreferences = SharedPreferences.getInstance();
  }

  Future<void> removePref(key) async {
    final prefs = await sharedPreferences;
    prefs.remove(key);
  }

  Future<bool?> getBool(key) async {
    final prefs = await sharedPreferences;
    return prefs.getBool(key);
  }

  Future setStringList(String key, List<String> values) async {
    final prefs = await sharedPreferences;
    prefs.setStringList(key, values);
  }

  Future setString(String key, String value) async {
    final prefs = await sharedPreferences;
    prefs.setString(key, value);
  }

  Future<List<String>> getStringList(String key) async {
    List<String> stringList = [];
    final prefs = await sharedPreferences;

    if (prefs.getStringList(key) != null) {
      stringList = prefs.getStringList(key) as List<String>;
    }

    return stringList;
  }

  Future<String?> getString(key) async {
    final prefs = await sharedPreferences;
    return prefs.getString(key);
  }
}
