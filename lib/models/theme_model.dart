import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/config/config.dart';

import '../config/config.dart';

class ThemeModel {
  final lightMode = ThemeData(
    primaryColor: Config().appColor,
    //accentColor: Config().appColor,
    iconTheme: IconThemeData(color: Colors.grey[900]),
    fontFamily: 'Manrope',
    scaffoldBackgroundColor: Colors.grey[100],
    brightness: Brightness.light,
    primaryColorDark: Colors.grey[800],
    primaryColorLight: Colors.white,
    secondaryHeaderColor: Colors.grey[600],
    shadowColor: Colors.grey[200],
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.grey[900],
      ),
      actionsIconTheme: IconThemeData(color: Colors.grey[900]),
      titleTextStyle: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.6,
        wordSpacing: 1,
        color: Colors.grey[900],
      ),
    ),
    textTheme: TextTheme(
      subtitle1: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 16, color: Colors.grey[900]),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Config().appColor,
      unselectedItemColor: Colors.grey[500],
    ),
  );

  final darkMode = ThemeData(
      primaryColor: Config().appColor,
      //accentColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
      brightness: Brightness.dark,
      primaryColorDark: Colors.grey[300],
      primaryColorLight: Colors.grey[800],
      secondaryHeaderColor: Colors.grey[400],
      shadowColor: Color(0xff282828),
      backgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        color: Color.fromARGB(255, 10, 10, 10),
        elevation: 1,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actionsIconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          letterSpacing: -0.6,
          wordSpacing: 1,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        subtitle1: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
      ));
}
