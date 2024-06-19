import 'package:flutter/material.dart';

void main() => runApp(Example());

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Business Types'),
        ),
        body: ListView(
          children: <Widget>[
            const ListTile(
              title: Text('Cars'),
            ),
            const ListTile(
              title: Text('Properties'),
            ),
            const ListTile(
              title: const Text('Mobiles'),
            ),
            const ListTile(
              title: Text('Fasition'),
            ),
            const ListTile(
              title: Text('Bikes'),
            ),
            const ListTile(
              title: Text('Watches'),
            ),
            const ListTile(
              title: Text('Shoes'),
            ),
          ],
        ),
      ),
    );
  }
}
