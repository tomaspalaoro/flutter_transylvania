import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Components/provider.dart';
import 'package:flutter_transylvania/Components/listado.dart';
import 'package:provider/provider.dart';

class ActividadesScreen extends StatefulWidget {
  const ActividadesScreen({super.key});

  @override
  State<ActividadesScreen> createState() => _ActividadesScreenState();
}

class _ActividadesScreenState extends State<ActividadesScreen> {
  @override
  Widget build(BuildContext context) {
    final conexionProvider = Provider.of<ConexionProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Actividades"),
        ),
        body: FutureBuilder(
            future: conexionProvider.loadActivities(),
            builder: (context, snapshot) =>
                listado(conexionProvider.getCurrentActivities())));
  }
}
