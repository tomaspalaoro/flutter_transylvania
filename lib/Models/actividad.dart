import 'package:flutter_transylvania/Models/modelo.dart';

class Actividad extends Modelo {
  Actividad(
      {super.nombre,
      super.descripcion,
      super.imagen,
      super.valoracion,
      super.comentarios});

  factory Actividad.fromJson(
      Map<String, dynamic> json, List<dynamic> comentarios) {
    //CALCULAR RATING
    double sumaValoraciones = 0.0;
    int numComentarios = 0;
    for (var comentario in comentarios) {
      sumaValoraciones += comentario["rating"];
      numComentarios++;
    }
    double mediaValoraciones =
        numComentarios > 0 ? sumaValoraciones / numComentarios : 0.0;

    return Actividad(
      nombre: json['name'],
      descripcion: json['description'],
      imagen: json['image'],
      comentarios: comentarios,
      valoracion: mediaValoraciones,
    );
  }
}
