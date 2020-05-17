import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_for_very_beginners/animation.dart';
import 'package:flutter_for_very_beginners/api_list.dart';
import 'package:flutter_for_very_beginners/google_maps.dart';
import 'package:flutter_for_very_beginners/login.dart';
import 'package:flutter_for_very_beginners/rive.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  Color myButtonColor = Colors.blue;
  Color myIconColor = Colors.grey;
  IconData myIcon = Icons.favorite_border;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dash F-01'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
//          if (formKey.currentState.validate()) {
//            Navigator.of(context).push(
//              MaterialPageRoute(
//                builder: (context) => MyNewScreen(controller.text),
//              ),
//            );
//          }
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MyApiList(),
            ),
          );
        },
      ),
      body: Column(
        children: <Widget>[
          Text('Hello Dash F-01'),
          ListTile(
            title: Text('Waleed Arshad'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            subtitle: Text('waleed@gmail.com'),
            leading: CircleAvatar(
              child: Text('W'),
            ),
            trailing: GestureDetector(
              child: Icon(myIcon, color: myIconColor),
              onTap: () {
                setState(() {
                  if (myIcon == Icons.favorite_border) {
                    myIcon = Icons.favorite;
                    myIconColor = Colors.red;
                  } else {
                    myIcon = Icons.favorite_border;
                    myIconColor = Colors.grey;
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Input is required';
                  }
                  return null;
                },
                controller: controller,
                decoration: InputDecoration(
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),
            ),
          ),
          RaisedButton(
            shape: StadiumBorder(),
            child: Text('Button one'),
            onPressed: () {
              print('Hello world');
            },
          ),
          RaisedButton(
            color: myButtonColor,
            shape: StadiumBorder(),
            child: Text('Button three'),
            onPressed: () {
              print('Hello world');
            },
          ),
          Row(
            children: <Widget>[
              Text('Hello'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: RaisedButton(
                    shape: StadiumBorder(),
                    child: Text('Get text from text field'),
                    onPressed: () {
                      insertValueFromTextFieldToFirebase();
//                      print(controller.text);
//                      setState(() {
//                        if (myButtonColor == Colors.blue) {
//                          myButtonColor = Colors.orange;
//                        } else {
//                          myButtonColor = Colors.blue;
//                        }
//                      });
                    },
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GoogleMapsScreen(),
                ),
              );
            },
            child: Text('Maps'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AnimationScreen(),
                ),
              );
            },
            child: Text('Animation'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Rive(),
                ),
              );
            },
            child: Text('Rive'),
          ),
        ],
      ),
    );
  }

  insertValueFromTextFieldToFirebase() async {
    Firestore.instance
        .collection('books')
        .document('5678')
        .setData({'title': controller.text, 'author': controller.text});
  }
}
