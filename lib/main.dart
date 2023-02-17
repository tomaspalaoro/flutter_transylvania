import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Screens/home.dart';
import 'package:flutter_transylvania/Screens/listado.dart';
import 'package:flutter_transylvania/Screens/login.dart';
import 'package:flutter_transylvania/Screens/ocio.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/listado': (context) => ListadoScreen(),
        '/ocio': (context) => OcioScreen(),
      },
    );
  }
}
