import 'package:flutter/material.dart';

class ThemeDataProvider {
  static ThemeData themeData() {
    final accentColor = Color.fromARGB(255, 57, 214, 138);
    final primaryColor = Color.fromARGB(255, 48, 68, 77);

    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      accentColor: accentColor,
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.white),
        headline2: TextStyle(
            fontSize: 42.0, fontWeight: FontWeight.bold, color: Colors.white),
        headline3: TextStyle(
            fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
        caption: TextStyle(
            fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
        bodyText1:
            TextStyle(fontSize: 16.0, fontFamily: 'Hind', color: Colors.white),
        bodyText2:
            TextStyle(fontSize: 16.0, fontFamily: 'Hind', color: Colors.white),
      ),
      buttonTheme: ButtonThemeData(
          buttonColor: accentColor,
          shape: RoundedRectangleBorder(),
          textTheme: ButtonTextTheme.accent),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: accentColor,
        textStyle: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      )),
    );
  }
}
