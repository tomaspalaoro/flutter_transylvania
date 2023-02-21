import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Models/modelo.dart';
// ignore_for_file: prefer_const_constructors

ListView listado(List<Modelo> objetos) {
  return ListView.builder(
    itemCount: objetos.length,
    itemBuilder: (BuildContext context, int index) {
      dynamic numValoracion = 5;
      if (objetos[index].valoracion != null) {
        numValoracion = objetos[index].valoracion;
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Image.network(
                objetos[index].imagen,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/info', arguments: {
                  'nombre': objetos[index].nombre,
                  'descripcion': objetos[index].descripcion,
                  'imagen': objetos[index].imagen,
                });
              },
            ),
            SizedBox(height: 8),
            Text(
              objetos[index].nombre,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                mostrarValoracion(numValoracion),
                Text(numValoracion.toString())
              ],
            ),
          ],
        ),
      );
    },
  );
}

///
///Generar estrellas hasta llegar a 5,
///rellenadas según la valoración convertida a int
///
Row mostrarValoracion(dynamic numValoracion) {
  int numEstrellas = numValoracion.toInt();
  return Row(
    children: List.generate(5, (index) {
      if (index < numEstrellas) {
        return Icon(Icons.star, color: Colors.yellow);
      } else {
        return Icon(Icons.star_border, color: Colors.yellow);
      }
    }),
  );
}
