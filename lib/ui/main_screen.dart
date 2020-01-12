import 'package:flutter/material.dart';
import 'package:quest_world/blocks/quests_block.dart';
import 'package:quest_world/ui/quests_tab.dart';

class MainScreen extends StatefulWidget {
  final controller;
  MainScreen({this.controller});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.controller,
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
    );
  }
}
