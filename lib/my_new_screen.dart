import 'package:flutter/material.dart';

class MyNewScreen extends StatelessWidget {
  final String text;
  MyNewScreen(this.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My new screen'),
      ),
      body: Center(
        child: Text(text),
      ),
    );
  }

}