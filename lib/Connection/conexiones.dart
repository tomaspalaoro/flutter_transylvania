import 'dart:convert'; //para trabajar con JSON
import 'package:flutter_transylvania/Models/actividad.dart';
import 'package:flutter_transylvania/Models/comentario.dart';
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
          Actividad nuevaActividad = Actividad.fromJson(element);
          if (!await validateImage(nuevaActividad.imagen)) {
            nuevaActividad.imagen =
                "https://picsum.photos/600/300"; //placeholder
          }
          activities.add(nuevaActividad);
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
          Cultura nuevaCultura = Cultura.fromJson(element);
          if (!await validateImage(nuevaCultura.imagen)) {
            nuevaCultura.imagen = "https://picsum.photos/600/300"; //placeholder
          }
          culturas.add(nuevaCultura);
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
          Ocio nuevoOcio = Ocio.fromJson(element);
          nuevoOcio.comentarios ??= [];
          if (!await validateImage(nuevoOcio.imagen)) {
            nuevoOcio.imagen = "https://picsum.photos/600/300"; //placeholder
          }
          ocios.add(nuevoOcio);
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
        print("Añadiendo actividad");
        url = Uri.parse('${RUTA}Actividad.json');
      } else if (modelo.contains("Ocio")) {
        print("Añadiendo Ocio");
        url = Uri.parse('${RUTA}Ocio.json');
      } else if (modelo.contains("Cultura")) {
        print("Añadiendo Cultura");
        url = Uri.parse('${RUTA}Cultura.json');
      } else {
        print("Default");
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

  Future<void> removeComentario(
      String modelo, String idModelo, String username) async {
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
        dynamic activity = json.firstWhere((a) => a['id'] == idModelo);

        List<dynamic> comentarios = activity['comments'];

        int index = comentarios.indexWhere((c) => c['username'] == username);

        if (index >= 0) {
          comentarios.removeAt(index);
          final updatedJson = jsonEncode(json);

          await http.put(url, body: updatedJson);
          print("Comentario Eliminado");
        } else {
          print('removeComentario No hay index');
        }
      } else {
        print('Petición fallida en removeComentario: ${response.statusCode}.');
      }
    } catch (e) {
      print('Excepcion removeComentario: $e');
    }
  }

  Future<bool> validateImage(String imageUrl) async {
    http.Response res;
    try {
      res = await http.get(Uri.parse(imageUrl));
    } catch (e) {
      return false;
    }

    if (res.statusCode != 200) return false;
    Map<String, dynamic> data = res.headers;
    return checkIfImage(data['content-type']);
  }

  bool checkIfImage(String param) {
    if (param == 'image/jpeg' || param == 'image/png' || param == 'image/gif') {
      return true;
    }
    return false;
  }
}
