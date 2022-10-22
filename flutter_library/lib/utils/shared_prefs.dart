import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gson/gson.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  final Gson _gson = Gson();
  SharedPreferences? _prefs;
  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() {
    return _instance;
  }

  SharedPrefs._internal() {
    _initialise();
  }

  Future _initialise() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void push({required String key, required Object value}) {
    if (_prefs == null) throw ("SharedPreferences not init");
    if (value is String) {
      _prefs!.setString(key, value);
    } else if (value is double) {
      _prefs!.setDouble(key, value);
    } else if (value is int) {
      _prefs!.setInt(key, value);
    } else if (value is bool) {
      _prefs!.setBool(key, value);
    } else if (value is List<String>) {
      _prefs!.setStringList(key, value);
    } else {
      _prefs!.setString(key, _gson.encode(value));
    }
  }

  T? get<T>(String key) {
    if (_prefs == null) throw ("SharedPreferences not init");
    return _prefs!.get(key) as T?;
  }

  Map<String, dynamic>? getValueFromJson(String jsonKey) {
    if (_prefs == null) throw ("SharedPreferences not init");
    final value = get<String>(jsonKey);
    return value != null ? jsonDecode(value) : null;
  }

  T? getObject<T>(T Function(Map<String, dynamic>) factory, String jsonKey) {
    if (_prefs == null) throw ("SharedPreferences not init");
    final value = getValueFromJson(jsonKey);
    debugPrint("getObject value: $value");
    if (value != null) {
      return factory.call(value);
    }
    return null;
  }

  removeAll() {
    if (_prefs == null) throw ("SharedPreferences not init");
    _prefs?.clear();
  }

  removeKey(String key) {
    if (_prefs == null) throw ("SharedPreferences not init");
    _prefs?.remove(key);
  }
}
