import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = const Color(0xFF5D9CEC);
  static Color backgroundColorLight = const Color(0xFFDFECDB);
  static Color backgroundColorDark = const Color(0xFF060E1E);
  static Color green = const Color(0xFF61E757);
  static Color red = const Color(0xFFEC4B4B);
  static Color black = const Color(0xFF141922);
  static Color grey = const Color(0xFFC8C9CB);
  static Color white = const Color(0xFFFFFFFF);

  static ThemeData lightTheme = ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
      ),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(textStyle:TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppTheme.white),foregroundColor: white )),
      textTheme: TextTheme(
          titleMedium: TextStyle(
              fontSize: 24, color: black, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: black),
          bodySmall: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: black),
          bodyMedium: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: primary)),
      primaryColor: primary,
      scaffoldBackgroundColor: backgroundColorLight,
      appBarTheme: AppBarTheme(
        
          backgroundColor: primary,
          titleTextStyle: TextStyle(
              color: white, fontWeight: FontWeight.bold, fontSize: 22)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primary,
        unselectedItemColor: grey,
      ),
      inputDecorationTheme: InputDecorationTheme(
        
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: grey.withOpacity(0.8), width: 1)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primary, width: 2))),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primary,
          foregroundColor: red,
          shape: CircleBorder(side: BorderSide(color: white))));
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColorDark,
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
    ),
  );
}
