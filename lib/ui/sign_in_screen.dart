import 'package:flutter/material.dart';
import 'package:quest_world/ui/main_screen.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Text("Welcome to"),
          Text("Quest World!"),
          TextFormField(
            decoration: InputDecoration(labelText: "Username"),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Password"),
          ),
          MaterialButton(
            child: Text("Sign In"),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainScreen())),
          ),
          MaterialButton(
            child: Text("Create new account"),
          )
        ],
      ),
    );
  }
}
