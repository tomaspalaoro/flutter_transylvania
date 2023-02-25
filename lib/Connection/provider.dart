import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Connection/conexiones.dart';
import 'package:flutter_transylvania/Models/actividad.dart';
import 'package:flutter_transylvania/Models/comentario.dart';

class ConexionProvider extends ChangeNotifier {
  final Conexiones _conexiones = Conexiones();
  List<Actividad> _activities = [];
  List<Comment> _comentarios = [];
  Actividad _actividad = Actividad();

  List<Actividad> getCurrentActivities() {
    return _activities;
  }

  List<Comment> getCurrentComments() {
    return _comentarios;
  }

  Actividad getActividadWhere(String modelo, String nombre) {
    _actividad = Actividad();
    _comentarios = [];
    for (var element in _activities) {
      if (element.nombre == nombre) {
        _actividad = element;
        for (var element in _actividad.comentarios) {
          _comentarios.add(Comment.fromJson(element));
        }
      }
    }
    return _actividad;
  }

  Future<void> loadActivities() async {
    _activities = await _conexiones.getActividades();
    print("loadActivities");
    notifyListeners();
  }

  Future<void> addComment(String activityId, Comment comment) async {
    _comentarios.add(comment);
    await _conexiones.addComentario(
        activityId, comment.comment, comment.rating, comment.username);
    notifyListeners();
  }
}
