import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:flutter/services.dart';

import 'app_preferences.dart';

const List<String> _kSupportedLanguages = ["en", "bg"];
const String _kDefaultLanguage = "en";

class GlobalTranslations {
  Locale _locale;
  Map<dynamic, dynamic> _localizedValues;
  Map<String, String> _cache = {};

  ///
  /// Returns the list of supported locales
  ///
  Iterable<Locale> supportedLocales() =>
      _kSupportedLanguages.map<Locale>((lang) => Locale(lang, ''));

  ///
  /// Returns the list of supported Languages
  ///
  Iterable<String> supportedLanguages() => _kSupportedLanguages;

  ///
  /// Return the translation that corresponds to the [key]
  ///
  /// The [key] might be a sequence of [key].[sub-key].[sub-key]
  ///
  String text(String key) {
    // Return the requested string
    String string = '** $key not found';

    if (_localizedValues != null) {
      // Check if the requested [key] is in the cache
      if (_cache[key] != null) {
        return _cache[key];
      }

      // Iterate the key until found or not
      bool found = true;
      Map<dynamic, dynamic> _values = _localizedValues;
      List<String> _keyParts = key.split('.');
      int _keyPartsLen = _keyParts.length;
      int index = 0;
      int lastIndex = _keyPartsLen - 1;

      while (index < _keyPartsLen && found) {
        var value = _values[_keyParts[index]];

        if (value == null) {
          // Not found => STOP
          found = false;
          break;
        }

        // Check if we found the requested key
        if (value is String && index == lastIndex) {
          string = value;

          // Add to cache
          _cache[key] = string;
          break;
        }

        // go to next subKey
        _values = value;
        index++;
      }
    }
    return string;
  }

  String get currentLanguage => _locale == null ? '' : _locale.languageCode;
  Locale get locale => _locale;

  ///
  /// One-time initialization
  ///
  Future<Null> init([String language]) async {
    if (_locale == null) {
      await setNewLanguage(language);
    }
    return null;
  }

  Future<Locale> loadDefaultLanguage() async {
    String preferredLanguage = await allTranslations.getPreferredLanguage();
    if (preferredLanguage == null || preferredLanguage.isEmpty) {
      await findSystemLocale();
      await init(Intl.shortLocale(Intl.systemLocale));
    } else {
      await init(preferredLanguage);
      Intl.defaultLocale = _locale.toString();
    }
    return _locale;
  }

  /// ----------------------------------------------------------
  /// Method that saves/restores the preferred language
  /// ----------------------------------------------------------
  getPreferredLanguage() async {
    return appPreferences
        .getString('language'); //_getApplicationSavedInformation('language');
  }

  setPreferredLanguage(String lang) async {
    return appPreferences.setString(
        'language', lang); //_setApplicationSavedInformation('language', lang);
  }

  ///
  /// Routine to change the language
  ///
  Future<Locale> setNewLanguage([String newLanguage]) async {
    String language = newLanguage;
    if (language == null) {
      language = await getPreferredLanguage();
    }

    // If not in the preferences, get the current locale (as defined at the device settings level)
    if (language == '') {
      String currentLocale = Platform.localeName.toLowerCase();
      if (currentLocale.length > 2) {
        if (currentLocale[2] == "-" || currentLocale[2] == "_") {
          language = currentLocale.substring(0, 2);
        }
      }
    }

    // Check if we are supporting the language
    // if not consider the default one
    if (!_kSupportedLanguages.contains(language)) {
      language = _kDefaultLanguage;
    }

    // Set the Locale
    _locale = Locale(language, "");

    // Load the language strings
    String jsonContent =
        await rootBundle.loadString("locale/i18n_${_locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);

    // save preferred language
    await setPreferredLanguage(language);

    // Clear the cache
    _cache = {};

    return _locale;
  }

  /// ==========================================================
  /// Singleton Factory
  ///
  static final GlobalTranslations _translations =
      GlobalTranslations._internal();
  factory GlobalTranslations() {
    return _translations;
  }
  GlobalTranslations._internal();
}

GlobalTranslations allTranslations = GlobalTranslations();
