import 'package:flutter_transylvania/Models/modelo.dart';

class Actividad extends Modelo {
  Actividad({super.nombre, super.descripcion, super.imagen});

  factory Actividad.fromJson(Map<String, dynamic> json) {
    return Actividad(
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      imagen: json['imagen'],
    );
  }
}
