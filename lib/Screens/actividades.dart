import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Models/actividad.dart';
import 'package:flutter_transylvania/Components/listado.dart';

class ActividadesScreen extends StatelessWidget {
  List<Actividad> actividades = [
    Actividad(
        nombre: "Prueba 1",
        descripcion: "Esto es una prueba",
        imagen: "https://via.placeholder.com/150"),
    Actividad(
        nombre: "Prueba 2",
        descripcion: "Esto es otra prueba",
        imagen: "https://via.placeholder.com/150"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actividades"),
      ),
      body: listado(actividades),
    );
  }
}
