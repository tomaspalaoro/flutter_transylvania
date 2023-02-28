import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Connection/conexiones.dart';
import 'package:flutter_transylvania/Models/actividad.dart';
import 'package:flutter_transylvania/Models/comentario.dart';
import 'package:flutter_transylvania/Models/cultura.dart';
import 'package:flutter_transylvania/Models/modelo.dart';
import 'package:flutter_transylvania/Models/ocio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConexionProvider extends ChangeNotifier {
  final Conexiones _conexiones = Conexiones();
  List<Actividad> _activities = [];
  List<Cultura> _culturas = [];
  List<Ocio> _ocios = [];
  List<Modelo> _listado = [];
  Modelo _objeto = Modelo();

  List<Comment> _comentarios = [];
  List<String> _accesibilidad = [];

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

  List<Ocio> getCurrentOcios() {
    return _ocios;
  }

  List<Cultura> getCurrentCulturas() {
    return _culturas;
  }

  List<Comment> getCurrentComments() {
    return _comentarios;
  }

  List<String> getCurrentAccesibilidad() {
    return _accesibilidad;
  }

  Modelo getWhere(String modelo, String nombre) {
    if (modelo.contains("Actividad")) {
      _listado = _activities;
    } else if (modelo.contains("Ocio")) {
      _listado = _ocios;
    } else if (modelo.contains("Cultura")) {
      _listado = _culturas;
    }
    _comentarios = [];
    _accesibilidad = [];
    for (var element in _listado) {
      if (element.nombre == nombre) {
        _objeto = element;
        for (var element in _objeto.comentarios) {
          _comentarios.add(Comment.fromJson(element));
        }
        for (var element in _objeto.accesibilidad) {
          _accesibilidad.add(element.toString());
        }
      }
    }
    return _objeto;
  }

  Future<void> loadActivities() async {
    _activities = await _conexiones.getActividades();
    print("loadActivities");
    notifyListeners();
  }

  Future<void> loadCulturas() async {
    _culturas = await _conexiones.getCulturas();
    print("loadCulturas");
    notifyListeners();
  }

  Future<void> loadOcios() async {
    _ocios = await _conexiones.getOcios();
    print("loadOcios");
    notifyListeners();
  }

  Future<void> addComment(String modelo, String id, Comment comment) async {
    print("add comment");
    bool yaHay = false;
    for (var element in _comentarios) {
      if (element.username == comment.username) {
        yaHay = true;
      }
    }
    if (!yaHay) {
      _comentarios.add(comment);
      await _conexiones.addComentario(
          modelo, id, comment.comment, comment.rating, comment.username);
    } else {
      print("Ya hay un comentario");
    }
    notifyListeners();
  }
}
