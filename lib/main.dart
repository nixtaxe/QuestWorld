import 'package:flutter/material.dart';
import 'package:quest_world/ui/sign_in_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
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
          headline: TextStyle(fontSize: 46.0, color: Colors.white, fontWeight: FontWeight.w300),
          title: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w300),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: Scaffold(
        body: SignInScreen(),
      ),
    );
  }
}
