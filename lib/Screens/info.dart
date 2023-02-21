import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  int rating = 0;
  bool favorito = false;

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text('Opciones de ocio'),
      ),
      body: Column(
        children: [
          Flexible(
            child: Image.network(
              arguments['imagen'],
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
                  arguments['nombre'] ?? "Nombre vacío",
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
              arguments['descripcion'] ?? "Descripción vacía",
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 16),
          //CAJA DE COMENTARIOS
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Comentarios
                  rowComentario("Maria",
                      "¡Emplazamiento increible con muchas facilidades!"),
                  rowComentario("Jose", "Muy bueno!!"),
                  rowComentario("Juan", "increíble"),
                  rowComentario("Pablo", "Está muy bien."),
                ],
              ),
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
      ),
    );
  }
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

Row rowComentario(String username, String comentario) {
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
                  rowEstrellasComments(3)
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
