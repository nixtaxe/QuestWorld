import 'package:flutter/material.dart';
import 'package:quest_world/blocks/quests_block.dart';
import 'package:quest_world/ui/quests_tab.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: QuestsTab(questsBlock.fetchActiveQuests,
                questsBlock.activeQuests, "Active quests")));
  }
}
