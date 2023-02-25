import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Connection/conexiones.dart';
import 'package:flutter_transylvania/Models/actividad.dart';
import 'package:flutter_transylvania/Models/comentario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConexionProvider extends ChangeNotifier {
  final Conexiones _conexiones = Conexiones();
  List<Actividad> _activities = [];
  List<Comment> _comentarios = [];
  List<String> _accesibilidad = [];
  Actividad _actividad = Actividad();
  late SharedPreferences _prefs;

  ConexionProvider() {
    inicializarPrefs();
  }

  Future<void> inicializarPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }

  SharedPreferences getPreferencias() {
    return _prefs;
  }

  List<Actividad> getCurrentActivities() {
    return _activities;
  }

  List<Comment> getCurrentComments() {
    return _comentarios;
  }

  List<String> getCurrentAccesibilidad() {
    return _accesibilidad;
  }

  Actividad getActividadWhere(String modelo, String nombre) {
    _actividad = Actividad();
    _comentarios = [];
    _accesibilidad = [];
    for (var element in _activities) {
      if (element.nombre == nombre) {
        _actividad = element;
        for (var element in _actividad.comentarios) {
          _comentarios.add(Comment.fromJson(element));
        }
        for (var element in _actividad.accesibilidad) {
          _accesibilidad.add(element.toString());
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
