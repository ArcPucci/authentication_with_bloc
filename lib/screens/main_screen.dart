import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key, required this.username, required this.password})
      : super(key: key);

  final String username;
  final String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User: " + username + ", password: " + password,
        ),
      ),
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: MaterialButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.red,
        ),
      ),
    );
  }
}
