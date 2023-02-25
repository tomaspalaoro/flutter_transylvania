import 'dart:convert'; //para trabajar con JSON
import 'package:flutter_transylvania/Models/actividad.dart';
import 'package:http/http.dart' as http; //import http

const String RUTA = "https://fluttertransylvania-default-rtdb.firebaseio.com/";

class Conexiones {
  Future<List<Actividad>> getActividades() async {
    List<Actividad> activities = [];
    try {
      final url = Uri.parse('${RUTA}Actividad.json');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> arrayJSON = jsonDecode(response.body);
        for (dynamic element in arrayJSON) {
          List<dynamic> listaComentarios = element["comments"];

          activities.add(Actividad.fromJson(element, listaComentarios));
        }
        //print("getActividades");
        return activities;
      } else {
        print('Petición fallida en getActividades: ${response.statusCode}.');
        return activities;
      }
    } catch (e) {
      print('Excepcion getActividades: $e');
      return activities;
    }
  }

  Future<void> addComentario(
      String activityId, String comment, double rating, String username) async {
    try {
      Uri url = Uri.parse('${RUTA}Actividad.json');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> json = jsonDecode(response.body);
        dynamic activity = json.firstWhere((a) => a['id'] == activityId);

        Map<String, dynamic> comentario = {
          'comment': comment,
          'rating': rating,
          'username': username,
        };

        activity['comments'].add(comentario);

        final updatedJson = jsonEncode(json);

        await http.put(url, body: updatedJson);
        print("Comentario Añadido");
      } else {
        print('Petición fallida en addComentario: ${response.statusCode}.');
      }
    } catch (e) {
      print('Excepcion addComentario: $e');
    }
  }
}
