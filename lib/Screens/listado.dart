import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

class ListadoScreen extends StatelessWidget {
  final List<String> _imageUrls = [
    "https://via.placeholder.com/150",
    "https://via.placeholder.com/150",
    "https://via.placeholder.com/150",
    "https://via.placeholder.com/150",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image List"),
      ),
      body: ListView.builder(
        itemCount: _imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Image.network(
                    _imageUrls[index],
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/ocio');
                  },
                ),
                SizedBox(height: 8),
                Text(
                  "Title ${index + 1}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(Icons.star, color: Colors.yellow);
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
