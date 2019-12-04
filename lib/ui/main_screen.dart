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
      QuestsTab(questsBlock.fetchActiveQuests, questsBlock.activeQuests, "Active Quests"),
      QuestsTab(questsBlock.fetchActiveQuests, questsBlock.activeQuests, "Completed Quests"),
      QuestsTab(questsBlock.fetchActiveQuests, questsBlock.activeQuests, "Abandoned Quests"),
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
          selectedItemColor: Colors.blue,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.flag),
              title: Text("Active")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.done),
              title: Text("Completed")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.pause_circle_outline),
              title: Text("Abandoned")
            )
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
            child: Text("Quest world"),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text("My Profile"),
            leading: Icon(Icons.person),
          ),
          ListTile(
            title: Text("My Quests"),
            leading: Icon(Icons.done_outline),
          ),
          ListTile(
            title: Text("All Quests"),
            leading: Icon(Icons.grid_on),
          )
        ],
      ),
    );
  }
}
