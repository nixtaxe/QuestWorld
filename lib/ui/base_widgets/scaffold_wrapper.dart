import 'package:flutter/material.dart';
import 'package:quest_world/blocks/quests_block.dart';
import 'package:quest_world/blocks/user_block.dart';
import 'package:quest_world/ui/base_widgets/appbar_wrapper.dart';
import 'package:quest_world/ui/main_screen.dart';

import '../quests_tab.dart';
import '../sign_in_screen.dart';

class ScaffoldWrapper extends StatefulWidget {
  final appBar;
  final child;

  ScaffoldWrapper({this.appBar, this.child});

  @override
  State<StatefulWidget> createState() => _ScaffoldWrapperState();
}

class _ScaffoldWrapperState extends State<ScaffoldWrapper> {
  var child;

  @override
  void initState() {
    super.initState();
    child = widget.child;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar ?? AppBarWrapper(),
      body: SafeArea(
        child: child,
      ),
      drawer: buildDrawer(context),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
                child: Text(
              "Quest world",
              style: Theme.of(context).textTheme.headline,
            )),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text(
              "My Profile",
              style: Theme.of(context).textTheme.title,
            ),
            leading: Icon(Icons.person),
          ),
          ListTile(
            title: Text(
              "My Quests",
              style: Theme.of(context).textTheme.title,
            ),
            leading: Icon(Icons.done_outline),
            onTap: () => setState(() {
              child = MainScreen();
              Navigator.pop(context);
            }),
          ),
          ListTile(
            title: Text(
              "All Quests",
              style: Theme.of(context).textTheme.title,
            ),
            leading: Icon(Icons.grid_on),
            onTap: () => setState(() {
              child = QuestsTab(
                loadQuests: questsBlock.fetchAvailableQuests,
                getQuestsStream: questsBlock.availableQuests,
                title: "Available Quests",
              );
              Navigator.pop(context);
            }),
          ),
          ListTile(
            title: Text(
              "Log Out",
              style: Theme.of(context).textTheme.title,
            ),
            onTap: () => logout(context),
          ),
        ],
      ),
    );
  }

  logout(context) async {
    await userBloc.deleteToken();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
        (route) => false);
  }
}
