import 'package:flutter/material.dart';

class UserDetailScreen extends StatefulWidget {
  final String userName;

  UserDetailScreen(this.userName);

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User details'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 4.0,
            color: color,
            child: ListTile(
              onTap: () {
                if (color == Colors.white)
                  setState(() {
                    color = Colors.red;
                  });
                else
                  setState(() {
                    color = Colors.white;
                  });
              },
              leading: Icon(Icons.person),
              title: Text('Hello ' + widget.userName),
              subtitle: Text('Welcome to the task for the second session'),
            ),
          )
        ],
      ),
    );
  }
}
