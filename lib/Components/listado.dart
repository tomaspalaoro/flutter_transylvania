import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Models/modelo.dart';
// ignore_for_file: prefer_const_constructors

ListView listado(List<Modelo> objetos) {
  return ListView.builder(
    itemCount: objetos.length,
    itemBuilder: (BuildContext context, int index) {
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
                Navigator.pushNamed(context, '/info', arguments: "");
              },
            ),
            SizedBox(height: 8),
            Text(
              objetos[index].nombre,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Row(
              children: List.generate(5, (index) {
                return Icon(Icons.star, color: Colors.yellow);
              }),
            ),
          ],
        ),
      );
    },
  );
}
