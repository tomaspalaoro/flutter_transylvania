import 'package:flutter/material.dart';
import 'dart:convert'; //para trabajar con JSON
import 'package:http/http.dart' as http; //import http

String url = "https://api.thecatapi.com/v1/categories";

Future<dynamic> _getListado() async {
  //dynamic indica que puede ser cualquier tipo de dato

  Uri uri = Uri.parse(url); //Uri es url formateada
  //se podría usar .https en lugar de .parse

  final respuesta = await http.get(uri);

  if (respuesta.statusCode == 200) {
    print(respuesta.body);
    return jsonDecode(respuesta.body);
  } else {
    print("Error en la respuesta");
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Ejemplo Future'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<dynamic>(
        future: _getListado(), //espera la respuesta
        builder: (context, snapshot) {
          //cuando llega la respuesta la muestro por pantalla
          if (snapshot.hasData) {
            //si es true hemos recibido datos
            print(snapshot);
            //estructura con la lista de datos que esperabamos
            return ListView(children: listado(snapshot.data));
          } else {
            print("No hay información");
            return Text("Sin data");
          }
        },
        initialData: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  List<Widget> listado(List<dynamic> info) {
    //lista de Widgets a partir del snapshot data
    List<Widget> lista = [];
    //for each elemento de la lista
    for (var miElemento in info) {
      lista.add(ListTile(
        leading: Icon(Icons.access_alarm),
        title: Text(miElemento["name"]),
        tileColor: Color.fromARGB(255, 207, 218, 227),
        trailing: Icon(Icons.point_of_sale_rounded),
      ));
      lista.add(Divider());
    }
    return lista;
  }
}
