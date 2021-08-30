import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  backgroundColor: Color(0xFF242526),
  scaffoldBackgroundColor: Color(0xFF18191a),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xFF18191a),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Color(0xFF18191a),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(

   type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xFFe4e6eb),
    selectedItemColor: Color(0xFFff9f1c),
    backgroundColor: Color(0xFF242526),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      height: 1.5
    ),
       bodyText2: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      height: 1.5
    ),
    subtitle1: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w300,
        color: Color(0xFFe4e6eb),
        height: 1.6),
    caption: TextStyle(
      height: 1.4,
        fontSize: 15, fontWeight: FontWeight.w200, color: Colors.white60),
  ),
  fontFamily: 'Jannah',
  iconTheme: IconThemeData(
color: Colors.white
  )
);

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.black38,
      selectedItemColor: Color(0xFFff9f1c),
      backgroundColor: Colors.white),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
      height: 1.5
    ),
      bodyText2: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
      height: 1.5
    ),
    subtitle1: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w300,
        color: Colors.black,
        height: 1.6),
    caption: TextStyle(
      height: 1.4,
        fontSize: 15, fontWeight: FontWeight.w200, color: Colors.grey[900]),
  ),
  fontFamily: 'Jannah',

  
);
