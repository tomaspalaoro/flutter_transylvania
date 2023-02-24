import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Connection/conexiones.dart';
import 'package:flutter_transylvania/Models/actividad.dart';
import 'package:flutter_transylvania/Models/comentario.dart';

class ConexionProvider extends ChangeNotifier {
  final Conexiones _conexiones = Conexiones();
  List<Actividad> _activities = [];
  Actividad _actividad = Actividad();

  List<Actividad> getCurrentActivities() {
    return _activities;
  }

  Actividad getCurrentActividad() {
    return _actividad;
  }

  Future<void> loadActivities() async {
    _activities = await _conexiones.getActividades();
    notifyListeners();
  }

  Future<void> loadWhere(String modelo, String nombre) async {
    _activities = await _conexiones.getActividades();
    for (var element in _activities) {
      if (element.nombre == nombre) {
        _actividad = element;
      }
    }
    notifyListeners();
  }

  void addComment(String activityId, Comment comment) async {
    print(comment.comment);
    await _conexiones.addComentario(
        activityId, comment.comment, comment.rating, comment.username);
    //_comments.add(comment);
    notifyListeners();
  }
}
