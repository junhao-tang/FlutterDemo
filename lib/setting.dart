import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo/util/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

const supportedLangs = ['en', 'zh'];

enum PrefKeys {
  lang,
}

class Settings extends ChangeNotifier {
  late bool testing;
  late HttpClient httpClient;
  final SharedPreferences prefs;
  Locale locale = window.locales[0];

  Settings.test(this.prefs) {
    testing = true;
    httpClient = HttpClient("");
    loadPrefs();
  }

  Settings.prod(this.prefs) {
    testing = false;
    httpClient = HttpClient("http://localhost");
    loadPrefs();
  }

  void loadPrefs() {
    String? lang = prefs.getString(PrefKeys.lang.toString());
    if (lang != null) setLocale(lang);
  }

  void setLocale(String lang) {
    if (!supportedLangs.contains(lang)) return;
    locale = Locale.fromSubtags(languageCode: lang);
    prefs.setString(PrefKeys.lang.toString(), lang);
    notifyListeners();
  }

  static Future<Settings> initSettings(bool test) async {
    final prefs = await SharedPreferences.getInstance();
    return (test ? Settings.test : Settings.prod)(prefs);
  }
}
