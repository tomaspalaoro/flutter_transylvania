import 'package:flutter_transylvania/Models/modelo.dart';

class Cultura extends Modelo {
  Cultura(
      {super.id,
      super.nombre,
      super.descripcion,
      super.imagen,
      super.valoracion,
      super.comentarios,
      super.accesibilidad});

  factory Cultura.fromJson(Map<String, dynamic> json) {
    List<dynamic> comentarios = json['comments'];
    //CALCULAR RATING
    double sumaValoraciones = 0.0;
    int numComentarios = 0;
    for (var comentario in comentarios) {
      sumaValoraciones += comentario["rating"];
      numComentarios++;
    }
    double mediaValoraciones = 0.0;
    if (numComentarios > 0) {
      try {
        //HACER MEDIA
        mediaValoraciones = sumaValoraciones / numComentarios;
        String unDecimal = mediaValoraciones.toStringAsFixed(1);
        mediaValoraciones = double.parse(unDecimal);
      } catch (e) {
        print(e);
      }
    }
    return Cultura(
        id: json['id'],
        nombre: json['name'],
        descripcion: json['description'],
        imagen: json['image'],
        comentarios: comentarios,
        valoracion: mediaValoraciones,
        accesibilidad: json['accesibilidad']);
  }
}
