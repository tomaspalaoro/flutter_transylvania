import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Components/conexiones.dart';
import 'package:flutter_transylvania/Models/actividad.dart';
// ignore_for_file: prefer_const_constructors

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  int rating = 0;
  bool favorito = false;

  Column mostrarInfo(Actividad actividad) {
    if (actividad.nombre != null) {
      return Column(
        children: [
          Flexible(
            child: Image.network(
              actividad.imagen ?? "",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16),
          //FILA DE TÍTULO, VALORACIÓN Y FAVORITO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(),
              //Texto en flexible y en overflow
              Flexible(
                child: Text(
                  actividad.nombre ?? "Nombre vacío",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20),
                ),
              ),

              //GENERAR VALORACIÓN
              Row(children: [
                for (int i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        rating = i;
                      });
                    },
                    child: Icon(
                      //Rellenar estrellas seleccionadas
                      i <= rating ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                    ),
                  ),
              ]),
              //BOTÓN FAVORITOS
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (!favorito) {
                      favorito = true;
                    } else {
                      favorito = false;
                    }
                  });
                },
                child: Icon(
                  Icons.favorite,
                  color: favorito ? Colors.red : Colors.white,
                ),
              ),
              Container(),
            ],
          ),
          //DESCRIPCIÓN
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              actividad.descripcion ?? "Descripción vacía",
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 16),
          //CAJA DE COMENTARIOS
          Expanded(
            child: SingleChildScrollView(
              child: generarComentarios(actividad.comentarios),
            ),
          ),
          //ESCRIBIR COMENTARIO
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Añade un comentario...',
                border: InputBorder.none,
              ),
            ),
          ),
          //BOTÓN ENVIAR
          TextButton(
            onPressed: () {
              //TODO
            },
            child: Text('Enviar'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 16),
            ),
          ),
          //DIRECCIÓN
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.map, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                "666 Transylvania Lane, Umbre, Romania",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column();
    }
  }

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    Actividad actividad = new Actividad();

    Future esperarActividad() async {
      print(arguments['nombre']);
      actividad = await Conexiones.getActividadWhere(
          arguments['modelo'], arguments['nombre']);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Opciones de ocio'),
        ),
        body: FutureBuilder(
          future: esperarActividad(),
          builder: (context, snapshot) => mostrarInfo(actividad),
        ));
  }
}

Column generarComentarios(List<dynamic> comentarios) {
  List<Row> rows = [];
  for (var element in comentarios) {
    rows.add(rowComentario(
        element['username'], element['comment'], element['rating']));
  }
  return Column(
    children: rows,
  );
}

Row rowEstrellasComments(int cantidadEstrellas) {
  List<Icon> icons = [];
  for (int i = 0; i < cantidadEstrellas; i++) {
    icons.add(Icon(Icons.star));
  }
  return Row(
    children: icons,
  );
}

Row rowComentario(String username, String comentario, var valoracion) {
  int cantEstrellas = valoracion.toInt();
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage('https://via.placeholder.com/150x150'),
          radius: 20,
        ),
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    username,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  rowEstrellasComments(cantEstrellas)
                ],
              ),
              SizedBox(height: 8),
              Text(
                comentario,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
