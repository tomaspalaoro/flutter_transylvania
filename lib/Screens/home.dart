import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel Transylvania'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 35, 6, 51),
              Color(0xFF8F14E9),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/htlogo.png'),
                ),
                SizedBox(height: 62.0),
                Text(
                  'Prepárate para una noche verdaderamente inolvidable en este espeluznante hotel, perfecto para los amantes de Halloween. ¡Ven si quieres pasar miedo y un buen rato a la vez!',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text('Actividades'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/actividades');
                      },
                    ),
                    ElevatedButton(
                      child: Text('Servicios'),
                      onPressed: () {
                        // TODO
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
