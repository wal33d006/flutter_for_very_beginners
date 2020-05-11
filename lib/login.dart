import 'package:flutter/material.dart';
import 'package:flutter_for_very_beginners/user_detail.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Login', style: Theme.of(context).textTheme.title,),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) return 'Username required';
                      return null;
                    },
                    controller: userNameController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Enter user ID',
                        labelText: 'User ID',
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) return 'Password required';
                      return null;
                    },
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.security),
                        hintText: 'Enter password',
                        labelText: 'Password',
                        border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UserDetailScreen(userNameController.text),
              ),
            );
          }
        },
        label: Text('Login'),
        icon: Icon(Icons.arrow_forward),
      ),
    );
  }
}
