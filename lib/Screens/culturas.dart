import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Components/listado.dart';
import 'package:flutter_transylvania/Connection/provider.dart';
import 'package:provider/provider.dart';

class CulturaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final conexionProvider = Provider.of<ConexionProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Cultura"),
        ),
        body: FutureBuilder(
            future: conexionProvider.loadCulturas(),
            builder: (context, snapshot) =>
                listado(conexionProvider.getCurrentCulturas())));
  }
}
