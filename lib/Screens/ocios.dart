import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Components/listado.dart';
import 'package:flutter_transylvania/Models/ocio.dart';

class OcioScreen extends StatelessWidget {
  List<Ocio> ocios = [
    Ocio(
        nombre: "Ocio 1",
        descripcion: "Esto es una prueba",
        imagen: "https://via.placeholder.com/150"),
    Ocio(
        nombre: "Ocio 2",
        descripcion: "Esto es otra prueba",
        imagen: "https://via.placeholder.com/150"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ocio"),
      ),
      body: listado(ocios),
    );
  }
}
