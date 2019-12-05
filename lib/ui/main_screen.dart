import 'package:flutter/material.dart';
import 'package:quest_world/blocks/quests_block.dart';
import 'package:quest_world/ui/quests_tab.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex;
  final int tabsLength = 3;
  List<QuestsTab> tabContent;

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;
    tabContent = [
      QuestsTab(
          loadQuests: questsBlock.fetchActiveQuests,
          getQuestsStream: questsBlock.activeQuests,
          title: "Active Quests"),
      QuestsTab(
          loadQuests: questsBlock.fetchActiveQuests,
          getQuestsStream: questsBlock.activeQuests,
          title: "Completed Quests"),
      QuestsTab(
          loadQuests: questsBlock.fetchActiveQuests,
          getQuestsStream: questsBlock.activeQuests,
          title: "Abandoned Quests"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabsLength,
      child: Scaffold(
        drawer: buildDrawer(),
        body: SafeArea(child: tabContent[_currentIndex]),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => setState(() => _currentIndex = index),
          currentIndex: _currentIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.flag), title: Text("Active")),
            BottomNavigationBarItem(
                icon: Icon(Icons.done), title: Text("Completed")),
            BottomNavigationBarItem(
                icon: Icon(Icons.pause_circle_outline),
                title: Text("Abandoned"))
          ],
        ),
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(child: Text("Quest world", style: Theme.of(context).textTheme.headline,)),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text("My Profile", style: Theme.of(context).textTheme.title,),
            leading: Icon(Icons.person),
          ),
          ListTile(
              title: Text("My Quests", style: Theme.of(context).textTheme.title,),
              leading: Icon(Icons.done_outline),
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MainScreen()))),
          ListTile(
            title: Text("All Quests", style: Theme.of(context).textTheme.title,),
            leading: Icon(Icons.grid_on),
          )
        ],
      ),
    );
  }
}
