// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.blueAccent,
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.black,
      textStyle: TextStyle(color: Colors.blue),
      side: const BorderSide(
          color: Colors.black,
          width: 2.0
      ),
      disabledForegroundColor: Colors.blue.withOpacity(0.38),
    )
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: outlineInputBorder,
    errorBorder: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    focusedBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
  ),
  primarySwatch: Colors.blue,
  canvasColor: Colors.blue,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      textStyle: const TextStyle(fontSize: 18.0),



      disabledBackgroundColor: Colors.lightBlueAccent,
    )
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    toolbarTextStyle: TextStyle(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
);
 OutlineInputBorder outlineInputBorder =  OutlineInputBorder(
borderSide: BorderSide(color: Colors.lightBlueAccent),
);