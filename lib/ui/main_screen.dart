import 'package:flutter/material.dart';
import 'package:quest_world/blocks/quests_block.dart';
import 'package:quest_world/ui/base_widgets/scaffold_wrapper.dart';
import 'package:quest_world/ui/quests_tab.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex;
  final int tabsLength = 3;
  var tabContent;

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;
    tabContent = [
      () => QuestsTab(
          loadQuests: questsBlock.fetchActiveQuests,
          getQuestsStream: questsBlock.activeQuests,
          title: "Active Quests"),
      () => QuestsTab(
          loadQuests: questsBlock.fetchActiveQuests,
          getQuestsStream: questsBlock.activeQuests,
          title: "Completed Quests"),
      () => QuestsTab(
          loadQuests: questsBlock.fetchActiveQuests,
          getQuestsStream: questsBlock.activeQuests,
          title: "Abandoned Quests"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      child: DefaultTabController(
        length: tabsLength,
        child: Scaffold(
          body: SafeArea(child: tabContent[_currentIndex]()),
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
      ),
    );
  }


}
