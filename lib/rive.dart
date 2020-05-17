import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Rive extends StatefulWidget {
  @override
  _RiveState createState() => _RiveState();
}

class _RiveState extends State<Rive> {
  String _animate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rive'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.fiber_manual_record),
        onPressed: () {
          setState(() {
            _animate = 'triangle';
          });
        },
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FlareActor(
              "assets/Bootcamp.flr",
              alignment: Alignment.center,
              animation: _animate,
            ),
          ),
        ],
      ),
    );
  }
}
