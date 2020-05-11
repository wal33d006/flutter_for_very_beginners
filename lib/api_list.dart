import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApiList extends StatefulWidget {
  @override
  _MyApiListState createState() => _MyApiListState();
}

class _MyApiListState extends State<MyApiList> {
  List<MyClass> names = List<MyClass>();

  List<dynamic> myList;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List from API'),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('books').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return new ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return new ListTile(
                            title: new Text(document['title']),
                            subtitle: new Text(document['author']),
                          );
                        }).toList(),
                      );
                  }
                },
              )

//      ListView.builder(
//              itemCount: names.length,
//              itemBuilder: (context, index) {
//                return ListTile(
//                  title: Text(names[index].name),
//                  subtitle: Text(names[index].email),
//                  trailing: Text(names[index].id.toString()),
//                );
//              },
//            ),
        );
  }

  void _fetchDataFromApi() async {
    Firestore.instance
        .collection('books')
        .document('1234')
        .setData({'title': 'Hello World', 'author': 'Waleed'});
    setState(() {
      _isLoading = true;
    });
    var response = await http.get('https://jsonplaceholder.typicode.com/users');
    print(response.body);
    var list = jsonDecode(response.body) as List;
    var myClassList = list.map((item) => MyClass.fromJson(item)).toList();
    setState(() {
      names = myClassList;
      _isLoading = false;
    });
  }
}

class MyClass {
  int id;
  String name;
  String username;
  String email;
  Address address;

  MyClass({this.id, this.name, this.username, this.email, this.address});

  MyClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    return data;
  }
}

class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Geo geo;

  Address({this.street, this.suite, this.city, this.zipcode, this.geo});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null ? new Geo.fromJson(json['geo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['suite'] = this.suite;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    if (this.geo != null) {
      data['geo'] = this.geo.toJson();
    }
    return data;
  }
}

class Geo {
  String lat;
  String lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
