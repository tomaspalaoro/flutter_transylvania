import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Components/listado.dart';
import 'package:flutter_transylvania/Connection/provider.dart';
import 'package:provider/provider.dart';

class OcioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final conexionProvider =
        Provider.of<ConexionProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text("Ocio"),
        ),
        body: FutureBuilder(
            future: conexionProvider.loadOcios(),
            builder: (context, snapshot) =>
                listado(conexionProvider.getCurrentOcios())));
  }
}
