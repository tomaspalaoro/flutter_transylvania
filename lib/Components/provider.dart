import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Components/conexiones.dart';
import 'package:flutter_transylvania/Models/actividad.dart';

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
}
