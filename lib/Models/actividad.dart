import 'package:flutter_transylvania/Models/modelo.dart';

class Actividad extends Modelo {
  Actividad({super.nombre, super.descripcion, super.imagen, super.valoracion});

  factory Actividad.fromJson(
      Map<String, dynamic> json, double mediaValoraciones) {
    return Actividad(
      nombre: json['name'],
      descripcion: json['description'],
      imagen: json['image'],
      valoracion: mediaValoraciones,
    );
  }
}
