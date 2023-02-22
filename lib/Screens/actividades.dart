import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Components/conexiones.dart';
import 'package:flutter_transylvania/Models/actividad.dart';
import 'package:flutter_transylvania/Components/listado.dart';

class ActividadesScreen extends StatefulWidget {
  const ActividadesScreen({super.key});

  @override
  State<ActividadesScreen> createState() => _ActividadesScreenState();
}

class _ActividadesScreenState extends State<ActividadesScreen> {
  List<Actividad> actividades = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actividades"),
      ),
      body: FutureBuilder(
        future: Conexiones.setActividades(actividades),
        builder: (context, snapshot) => listado(actividades),
      ),
    );
  }
}
