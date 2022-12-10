import 'package:flutter/material.dart';

class GAThemeData {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Pretendard',
      textTheme: gaTextTheme(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(0xff4D6FFF),
      ).copyWith(
        primary: Color(0xff4D6FFF),
        background: Color(0xffF3F3F3),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData();
  }
}

TextTheme gaTextTheme() {
  return TextTheme(
    displaySmall: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 36,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 28,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 24,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 17,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 17,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 15,
    ),
  );
}
