import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quest_world/blocks/user_block.dart';
import 'package:quest_world/ui/base_widgets/scaffold_wrapper.dart';
import 'package:quest_world/ui/main_screen.dart';
import 'package:quest_world/ui/sign_in_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
      .copyWith(statusBarIconBrightness: Brightness.light));

  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    userBloc.checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3FB7EB),
        primaryColorDark: Color(0xFF2DA4D8),
        accentColor: Color(0xFF1537E7),
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
            headline: TextStyle(
                fontSize: 46.0,
                color: Colors.white,
                fontWeight: FontWeight.w300),
            title: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            button: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.85))),
      ),
      home: Scaffold(
        //TODO add token verification
        body: StreamBuilder(
            stream: userBloc.hasToken(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return SignInScreen();
              }

              if (snapshot.hasData) {
                final hasToken = snapshot.data;
                return hasToken ? ScaffoldWrapper(initialTabName: "Main",) : SignInScreen();
              }

              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }),
      ),
    );
  }
}
