import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPreferences? _prefs;

  Future initialise() async {
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
    }
  }

  get<T>(String key){
    if(_prefs == null) throw("SharedPreferences not init");
    return _prefs!.get(key) as T;
  }
}
