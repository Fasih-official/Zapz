import 'package:flutter/material.dart';

class AppLanguage {
  ///Default Language
  static Locale defaultLanguage = Locale("pt");

  ///List Language support in Application
  static List<Locale> supportLanguage = [
    Locale("en"),
//    Locale("vi"),
//    Locale("ar"),
//    Locale("zh"),
//    Locale("ko"),
//    Locale("ja"),
    Locale("de"),
    Locale("fr"),
    Locale("it"),
    Locale("pt")
  ];

  ///Singleton factory
  static final AppLanguage _instance = AppLanguage._internal();

  factory AppLanguage() {
    return _instance;
  }

  AppLanguage._internal();
}
