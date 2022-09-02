import 'package:flutter/material.dart';

ThemeData getTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.blue,
    fontFamily: 'Georgia',
    scaffoldBackgroundColor: Colors.black,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.green,
    ),
    textTheme: const TextTheme(
      headline4: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: "Roboto",
      ),
      headline5: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: "Roboto",
      ),
      headline6: TextStyle(
        color: Colors.white,
        fontFamily: "Roboto",
      ),
      bodyText1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: "Roboto",
      ),
      bodyText2: TextStyle(
        color: Colors.grey,
        fontFamily: "Roboto",
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.grey, size: 25),
  );
}
