import 'package:flutter/material.dart';
import 'package:quest_world/blocs/user_bloc.dart';
import 'package:quest_world/models/user_model.dart';
import 'package:quest_world/ui/base_widgets/scaffold_wrapper.dart';
import 'package:quest_world/ui/main_screen.dart';
import 'package:toast/toast.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  static GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final UserRequest user = UserRequest();

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
        ),
      ),
    );
  }

  void loginUser(context) async {
    formKey.currentState.save();
    try {
      final success = await userBloc.login(user.name, user.password);
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
