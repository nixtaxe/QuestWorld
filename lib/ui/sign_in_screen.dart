import 'package:flutter/material.dart';
import 'package:quest_world/blocks/quests_block.dart';
import 'package:quest_world/blocks/user_block.dart';
import 'package:quest_world/models/user_model.dart';
import 'package:quest_world/ui/main_screen.dart';

class SignInScreen extends StatelessWidget {
  UserRequest user = UserRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome to",
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(fontSize: 34.0),
              ),
              Text(
                "Quest World!",
                style: Theme.of(context).textTheme.headline,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Username",
                    labelStyle: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.black54, fontSize: 20.0)),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.black54, fontSize: 20.0)),
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Sign In",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                      color: Theme.of(context).accentColor,
                      onPressed: () => loginUser(context),
                    ),
                  ),
                ],
              ),
              MaterialButton(
                child: Text("Create new account"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void loginUser(context) async {
    final success = await userBloc.login(user.name, user.password);
    if (success) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainScreen()));
    }
  }
}
