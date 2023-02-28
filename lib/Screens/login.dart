import 'package:flutter/material.dart';
import 'package:flutter_transylvania/Connection/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'dart:convert'; //para trabajar con JSON
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart'; //import http

// ignore_for_file: prefer_const_constructors

final ip = "192.168.202.21";
final ruta = "http://$ip/gestionhotelera/sw_user.php";

final GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _rememberMe = false;

  Future<void> _loginGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Use the googleAuth.idToken and googleAuth.accessToken
      // to authenticate with your backend server.
    } catch (error) {
      print(error);
    }
  }

  late ConexionProvider conexionProvider;

  @override
  Widget build(BuildContext context) {
    conexionProvider = Provider.of<ConexionProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 8, 69),
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(64.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/htIniciales.png',
                  height: 100,
                ),
                SizedBox(height: 16.0),
                SizedBox(height: 24.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //BOTÓN GOOGLE
                      ElevatedButton(
                        onPressed: () {
                          onPressed:
                          _loginGoogle();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 12, 62, 169),
                          minimumSize: Size(double.infinity,
                              50), // Set minimum width and height
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/google_logo.png',
                              height: 34.0,
                            ),
                            SizedBox(width: 10),
                            Text('Entrar con Google'),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 20), //Tamaño separador
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 2,
                              color: Colors.grey, //Color del separador
                            ),
                          ),
                        ),
                      ),
                      //FORMULARIO
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Introduce tu email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Contraseña',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Introduce una contraseña';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value!;
                              });
                            },
                          ),
                          Text('Recordarme'),

                          SizedBox(width: 16.0),
                          //BOTÓN LOGIN NORMAL
                          ElevatedButton(
                            child: Text('Iniciar sesión'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                _postHttp();
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      //BOTÓN REGISTRO
                      GestureDetector(
                        onTap: () {
                          // TODO
                        },
                        child: Text(
                          '¿Usuario nuevo? Regístrate',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _postHttp() async {
    Map<String, String> params = {
      'action': 'login',
      'user': '{"email": "$_email", "password": "$_password"}',
    };

    try {
      final url = Uri.parse(ruta);
      final response = await http
          .post(url, body: params)
          .timeout(const Duration(seconds: 5));
      ;
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          print(jsonResponse['data']['nombre']);
          conexionProvider
              .getPreferencias()
              .setString("user", jsonResponse['data']['nombre'] ?? "Prueba");
          print('Usuario correcto');
          entrarHome();
        } else {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
                title: const Text('Error al iniciar sesión'),
                content: const Text('Usuario incorrecto'),
                actions: [
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ]),
          );
        }
      } else {
        print('Petición fallida: ${response.statusCode}.');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  void entrarHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }
}
