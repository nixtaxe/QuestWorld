import 'package:flutter/material.dart';
import 'package:quest_world/blocs/user_bloc.dart';
import 'package:quest_world/models/user_model.dart';
import 'package:toast/toast.dart';

import 'base_widgets/scaffold_wrapper.dart';
import 'main_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserRequest user = UserRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: Colors.black54, fontSize: 20.0)),
                    onSaved: (String value) {
                      user.name = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: Colors.black54, fontSize: 20.0)),
                    obscureText: true,
                    onSaved: (String value) {
                      user.password = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Repeat password",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: Colors.black54, fontSize: 20.0)),
                    obscureText: true,
                    validator: (value) {
                      formKey.currentState.save();
                      if (value != user.password) {
                        return "Passwords are not the same";
                      }
                      return null;
                    },
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
                              "Register",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                          color: Theme.of(context).accentColor,
                          onPressed: () => registerUser(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void registerUser(context) async {
    if (!formKey.currentState.validate())
      return;

    formKey.currentState.save();
    try {
      final success = await userBloc.register(user.name, user.password);
      if (success) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ScaffoldWrapper(child: MainScreen(),)));
      }
    } catch (e) {
      Toast.show(e.toString(), context, duration: Toast.LENGTH_LONG);
    }
  }

}