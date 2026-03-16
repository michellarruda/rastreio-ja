// Rastreio Já — Wrapper SharedPreferences
library;

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  PreferencesService(this._prefs);
  final SharedPreferences _prefs;

  Future<bool> setString(final String key, final String value) =>
      _prefs.setString(key, value);

  String? getString(final String key) => _prefs.getString(key);

  Future<bool> setInt(final String key, final int value) =>
      _prefs.setInt(key, value);

  int? getInt(final String key) => _prefs.getInt(key);

  Future<bool> remove(final String key) => _prefs.remove(key);
}
