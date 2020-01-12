import 'package:flutter/material.dart';
import 'package:quest_world/blocks/quests_block.dart';
import 'package:quest_world/ui/base_widgets/scaffold_wrapper.dart';
import 'package:quest_world/ui/quests_tab.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{
  TabController controller;
  final int tabsLength = 3;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: tabsLength);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColor,
        child: TabBar(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          controller: controller,
          tabs: <Tab>[
            Tab(
                text: "Active"),
            Tab(
                text: "Completed"),
            Tab(
                text: "Interrupted")
          ],
        ),
      ),
      child: TabBarView(
        controller: controller,
        children: <Widget>[
          QuestsTab(
              loadQuests: questsBlock.fetchActiveQuests,
              getQuestsStream: questsBlock.activeQuests,
              title: "Active Quests"),
          QuestsTab(
              loadQuests: questsBlock.fetchFinishedQuests,
              getQuestsStream: questsBlock.finishedQuests,
              title: "Completed Quests"),
          QuestsTab(
              loadQuests: questsBlock.fetchAbandonedQuests,
              getQuestsStream: questsBlock.abandonedQuests,
              title: "Abandoned Quests"),
        ],
      )
    );
  }


}
