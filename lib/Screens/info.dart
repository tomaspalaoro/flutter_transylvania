import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Connection/provider.dart';
import 'package:flutter_transylvania/Models/actividad.dart';
import 'package:flutter_transylvania/Models/comentario.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore_for_file: prefer_const_constructors

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  int rating = 0;
  bool favorito = false;

  bool inicializado = false;

  dynamic conexionProvider;
  Actividad actividad = Actividad();
  List<Comment> comentarios = [];
  List<String> accesibilidad = [];

  void inicializar() {
    if (!inicializado) {
      comentarios = conexionProvider.getCurrentComments();
      accesibilidad = conexionProvider.getCurrentAccesibilidad();
      inicializado = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map;
    conexionProvider = Provider.of<ConexionProvider>(context, listen: false);
    actividad = conexionProvider.getActividadWhere(
        arguments['modelo'], arguments['nombre']);
    inicializar();
    return Scaffold(
        appBar: AppBar(
          title: Text('Opciones de ocio'),
        ),
        body: Column(
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
            //ICONOS
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //CÓDIGO QR
                IconButton(
                  icon: Icon(Icons.qr_code),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                QrImage(
                                  data: actividad.nombre,
                                  version: QrVersions.auto,
                                  size: 200.0,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.accessibility),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Opciones de accesibilidad'),
                        content: SizedBox(
                          height: 200.0,
                          width: 200.0,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: accesibilidad.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(accesibilidad[index]),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                    icon: Icon(Icons.map),
                    onPressed: (() {
                      openMaps(46.224625197459055, 24.776022175201398);
                    })),
              ],
            ),
            SizedBox(height: 16),
            //CAJA DE COMENTARIOS
            Expanded(
              child: SingleChildScrollView(
                child: generarComentarios(comentarios),
              ),
            ),
            Row(
              children: [
                //ESCRIBIR COMENTARIO
                Expanded(
                  //padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    //controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Añade un comentario...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                //BOTÓN ENVIAR
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final comment = Comment(
                      comment: 'Prueba',
                      username: 'Prueba',
                      rating: 5.0,
                    );
                    conexionProvider.addComment(actividad.id, comment);
                    setState(() {}); //actualizar comentarios
                  },
                ),
              ],
            ),
          ],
        ));
  }
}

void openMaps(double latitude, double longitude) async {
  final String googleMapsUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  Uri uri = Uri.parse(googleMapsUrl);
  try {
    await launchUrl(uri);
  } catch (e) {}
}

Column generarComentarios(List<Comment> comentarios) {
  List<Row> rows = [];
  for (var element in comentarios) {
    rows.add(rowComentario(element.username, element.comment, element.rating));
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
