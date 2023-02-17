import 'package:flutter/material.dart';

final ThemeData temaOscuro = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  primaryColor: Colors.purple[900],
  //
  scaffoldBackgroundColor: Colors.grey[900],
  //recuadro textfield
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.black),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.purple),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.purpleAccent), //cursor textfield
  //
  buttonTheme: ButtonThemeData(buttonColor: Colors.purple),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.purple))),
  //
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
    headline5: TextStyle(color: Colors.white), //titulo login
    headline6: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    subtitle1: TextStyle(color: Colors.purpleAccent), //textfield
    bodyText2: TextStyle(fontSize: 14.0, color: Colors.white),
  ),
);
