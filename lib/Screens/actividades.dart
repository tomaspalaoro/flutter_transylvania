import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Models/actividad.dart';
import 'package:flutter_transylvania/Components/listado.dart';

import 'dart:convert'; //para trabajar con JSON
import 'package:http/http.dart' as http; //import http

final String ruta =
    "https://fluttertransylvania-default-rtdb.firebaseio.com/Actividad.json";

class ActividadesScreen extends StatefulWidget {
  @override
  State<ActividadesScreen> createState() => _ActividadesScreenState();
}

class _ActividadesScreenState extends State<ActividadesScreen> {
  List<Actividad> actividades = [];

  Future<dynamic> _getActividades() async {
    try {
      final url = Uri.parse(ruta);
      final response = await http.get(url);
      ;
      if (response.statusCode == 200) {
        List<dynamic> arrayJSON = jsonDecode(response.body);
        for (var element in arrayJSON) {
          actividades.add(Actividad.fromJson(element));
        }
      } else {
        print('Petición fallida: ${response.statusCode}.');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actividades"),
      ),
      body: FutureBuilder(
        future: _getActividades(),
        builder: (context, snapshot) => listado(actividades),
      ),
    );
  }
}
