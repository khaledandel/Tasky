import 'package:shared_preferences/shared_preferences.dart';

class PreferanceManager {
  static final PreferanceManager _instance = PreferanceManager._internal();

  // Factory Constractot TO return Singlrton Instance
  factory PreferanceManager() {
    return _instance;
  }

  // private Constractour
  PreferanceManager._internal();

  late final SharedPreferences _prefrance;

  inti() async {
    _prefrance = await SharedPreferences.getInstance();
  }

  // Set All Method In SharedPreferance
  Future<bool> setString(String key, String value) async {
    return await _prefrance.setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefrance.setStringList(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _prefrance.setDouble(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefrance.setInt(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefrance.setBool(key, value);
  }

  // get All Method In SharedPreferance
  String? getString(String key) {
    return _prefrance.getString(key);
  }

  List<String>? getStringList(String key) {
    return _prefrance.getStringList(key);
  }

  double? getDouble(String key) {
    return _prefrance.getDouble(key);
  }

  int? getInt(String key) {
    return _prefrance.getInt(key);
  }

  bool? getBool(String key) {
    return _prefrance.getBool(key);
  }

  // remove All Method In SharedPreferance
  remove(String key) async {
    return _prefrance.remove(key);
  }

  clear() async {
    return _prefrance.clear();
  }
}
