import 'package:flutter/material.dart';

ThemeData themeData() {
  return ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    hoverColor: Colors.orange[700],
    focusColor: Color(0xff0B2512),
    canvasColor: Colors.grey[50],
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.black,
    ),
    highlightColor: Color(0xffFCE192),
    buttonColor: Colors.orange,
  );
}