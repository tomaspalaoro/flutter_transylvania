import 'package:flutter/material.dart';

class OcioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Image Screen'),
      ),
      body: MiColumna(),
    );
  }
}

class MiColumna extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: Image.asset(
            'assets/images/my_image.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Row(
          children: <Widget>[
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.star, color: Colors.yellow),
            Icon(Icons.favorite, color: Colors.red),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor enim mauris, ut sagittis felis volutpat id. Nulla facilisi.',
            style: TextStyle(fontSize: 16),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.map, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              '123 Main St, Anytown USA',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
