import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_pp/shared/components/constants.dart';

ThemeData lightTheme=ThemeData(
    brightness: Brightness.light,
  primarySwatch:default_color,
  scaffoldBackgroundColor:Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,

    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle:SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.light,
    ),
    backgroundColor: Colors.white,
    elevation: 20.0,

  ),
    fontFamily: 'Jannah'
);
ThemeData darkTheme=ThemeData(
  brightness: Brightness.dark,
  primarySwatch: default_color,
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: AppBarTheme(

    titleSpacing: 20.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,

    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.grey[900],
    elevation: 30.0,
  ),
  backgroundColor:Colors.grey[900] ,
  fontFamily: 'Jannah'
);
