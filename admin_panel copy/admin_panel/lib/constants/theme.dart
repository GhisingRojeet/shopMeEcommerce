// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.blueAccent,
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    foregroundColor: Colors.black,
    textStyle: TextStyle(color: Colors.red),
    side: const BorderSide(color: Colors.black, width: 2.0),
    disabledForegroundColor: Colors.red.withOpacity(0.38),
  )),
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
        minimumSize: Size(double.infinity, 48),

    backgroundColor: Colors.blue,
    textStyle: const TextStyle(fontSize: 18.0),
    disabledBackgroundColor: Colors.blue,
  )),
  appBarTheme: AppBarTheme(
    centerTitle: true,
   
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
    toolbarTextStyle: TextStyle(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
);
OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey),
);
