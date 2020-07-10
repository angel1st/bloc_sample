import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

const String _storageKey = "PlantCareReminder_";

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class AppPreferences {
  ///
  /// Application Preferences related
  ///
  /// ----------------------------------------------------------
  /// Generic routine to fetch an application preference
  /// ----------------------------------------------------------
  Future<String> getString(String name) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getString(_storageKey + name) ?? null;
  }

  Future<int> getInt(String name) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getInt(_storageKey + name) ?? null;
  }

  Future<bool> getBool(String name) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getBool(_storageKey + name) ?? null;
  }

  /// ----------------------------------------------------------
  /// Generic routine to saves an application preference
  /// ----------------------------------------------------------
  Future<bool> setString(String name, String value) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.setString(_storageKey + name, value);
  }

  Future<bool> setInt(String name, int value) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.setInt(_storageKey + name, value);
  }

  Future<bool> setBool(String name, bool value) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.setBool(_storageKey + name, value);
  }

  static final AppPreferences _preferences = new AppPreferences._internal();
  factory AppPreferences() {
    return _preferences;
  }
  AppPreferences._internal();
}

AppPreferences appPreferences = AppPreferences();
