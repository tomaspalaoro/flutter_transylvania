import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Screens/actividades.dart';
import 'package:flutter_transylvania/Screens/home.dart';
import 'package:flutter_transylvania/Components/listado.dart';
import 'package:flutter_transylvania/Screens/login.dart';
import 'package:flutter_transylvania/Screens/info.dart';
import 'package:flutter_transylvania/Screens/ocios.dart';
import 'package:flutter_transylvania/theme.dart';
import 'dart:convert'; //para trabajar con JSON
import 'package:http/http.dart' as http; //import http

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: temaOscuro,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/home': (context) => HomeScreen(),
        '/actividades': (context) => ActividadesScreen(),
        '/ocio': (context) => OcioScreen(),
        '/info': (context) => InfoScreen(),
      },
    );
  }
}
