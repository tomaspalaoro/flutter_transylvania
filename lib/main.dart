import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Connection/provider.dart';
import 'package:flutter_transylvania/Screens/actividades.dart';
import 'package:flutter_transylvania/Screens/culturas.dart';
import 'package:flutter_transylvania/Screens/home.dart';
import 'package:flutter_transylvania/Screens/info.dart';
import 'package:flutter_transylvania/Screens/login.dart';
import 'package:flutter_transylvania/Screens/ocios.dart';
import 'package:flutter_transylvania/theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ConexionProvider>(
          create: (context) => ConexionProvider(),
          lazy: false,
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aaaaa',
      theme: temaOscuro,
      initialRoute: '/home',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/cultura': (context) => CulturaScreen(),
        '/actividades': (context) => ActividadesScreen(),
        '/ocio': (context) => OcioScreen(),
        '/info': (context) => InfoScreen(),
      },
    );
  }
}
