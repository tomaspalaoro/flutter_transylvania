import 'dart:convert'; //para trabajar con JSON
import 'package:flutter_transylvania/Models/actividad.dart';
import 'package:flutter_transylvania/Models/cultura.dart';
import 'package:flutter_transylvania/Models/ocio.dart';
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
          activities.add(Actividad.fromJson(element));
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

  Future<List<Cultura>> getCulturas() async {
    List<Cultura> culturas = [];
    try {
      final url = Uri.parse('${RUTA}Cultura.json');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> arrayJSON = jsonDecode(response.body);
        for (dynamic element in arrayJSON) {
          culturas.add(Cultura.fromJson(element));
        }
        return culturas;
      } else {
        print('Petición fallida en getCulturas: ${response.statusCode}.');
        return culturas;
      }
    } catch (e) {
      print('Excepcion getCulturas: $e');
      return culturas;
    }
  }

  Future<List<Ocio>> getOcios() async {
    List<Ocio> ocios = [];
    try {
      final url = Uri.parse('${RUTA}Ocio.json');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> arrayJSON = jsonDecode(response.body);
        for (dynamic element in arrayJSON) {
          ocios.add(Ocio.fromJson(element));
        }
        return ocios;
      } else {
        print('Petición fallida en getOcios: ${response.statusCode}.');
        return ocios;
      }
    } catch (e) {
      print('Excepcion getOcios: $e');
      return ocios;
    }
  }

  Future<void> addComentario(String modelo, String id, String comment,
      double rating, String username) async {
    try {
      Uri url;
      if (modelo.contains("Actividad")) {
        url = Uri.parse('${RUTA}Actividad.json');
      } else if (modelo.contains("Ocio")) {
        url = Uri.parse('${RUTA}Ocio.json');
      } else if (modelo.contains("Cultura")) {
        url = Uri.parse('${RUTA}Cultura.json');
      } else {
        url = Uri.parse('${RUTA}Actividad.json');
      }
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> json = jsonDecode(response.body);
        dynamic activity = json.firstWhere((a) => a['id'] == id);

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
