import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

class OcioScreen extends StatelessWidget {
  const OcioScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opciones de ocio'),
      ),
      body: Column(
        children: [
          Flexible(
            child: Image.network(
              'https://www.lavanguardia.com/files/og_thumbnail/uploads/2021/12/09/61b224feec6bc.jpeg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rowEstrellas(5),
              Container(),
              Icon(Icons.favorite, color: Colors.red),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor enim mauris, ut sagittis felis volutpat id. Nulla facilisi.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 16),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Añade un comentario...',
                border: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO enviar comentario
            },
            child: Text(
              'Enviar',
              style: TextStyle(fontSize: 16),
            ),
          ),
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

Row rowEstrellas(int cantidadEstrellas) {
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
            color: Colors.grey[300],
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
                  rowEstrellas(3)
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
