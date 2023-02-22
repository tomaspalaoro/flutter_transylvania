import 'dart:convert'; //para trabajar con JSON
import 'package:flutter_transylvania/Models/actividad.dart';
import 'package:flutter_transylvania/constants.dart';
import 'package:http/http.dart' as http; //import http

class Conexiones {
  static Future<dynamic> setActividades(List<Actividad> actividades) async {
    try {
      final url = Uri.parse(JSON_ACTIVIDADES);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> arrayJSON = jsonDecode(response.body);
        for (var element in arrayJSON) {
          List<dynamic> listaComentarios = element["comments"];

          actividades.add(Actividad.fromJson(element, listaComentarios));
        }
      } else {
        print('Petición fallida: ${response.statusCode}.');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  static Future<Actividad> getActividadWhere(
      String modelo, String nombre) async {
    try {
      final url = Uri.parse(JSON_ACTIVIDADES);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> json = jsonDecode(response.body);
        print(json);
        var activity = json.firstWhere((a) => a['name'] == nombre);
        print(activity);
        List<dynamic> listaComentarios = activity["comments"];
        return Actividad.fromJson(activity, listaComentarios);
      } else {
        print('Petición fallida: ${response.statusCode}.');
        return Actividad();
      }
    } catch (e) {
      print('Exception: $e');
      return Actividad();
    }
  }
}
