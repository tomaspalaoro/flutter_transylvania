import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel Transylvania'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Hotel Transylvania',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              Text(
                'Prepárate para una noche verdaderamente inolvidable en este espeluznante hotel, perfecto para los amantes de Halloween. ¡Ven si quieres pasar miedo y un buen rato a la vez!',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    child: Text('Ocio'),
                    onPressed: () {
                      // TODO
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
    );
  }
}
