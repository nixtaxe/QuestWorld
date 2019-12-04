import 'package:flutter/material.dart';
import 'package:quest_world/models/quest_model.dart';

class QuestDescriptionScreen extends StatelessWidget {
  final QuestItem quest;

  QuestDescriptionScreen({this.quest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Icon(Icons.all_out),
          Text(quest.name),
          Text(quest.description),
          Text("Duration: ${quest.duration ?? 1} ms")
        ]),
      ),
    );
  }
}
