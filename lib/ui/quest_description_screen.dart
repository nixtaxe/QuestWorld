import 'package:flutter/material.dart';
import 'package:quest_world/models/quest_model.dart';
import 'package:quest_world/ui/base_widgets/scaffold_wrapper.dart';

class QuestDescriptionScreen extends StatelessWidget {
  final QuestItem quest;

  QuestDescriptionScreen({this.quest});

  //TODO change appearance (add current steps list)
  //TODO add new quest screen
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      child: Column(children: [
        Icon(Icons.all_out),
        Text(quest.name),
        Text(quest.descriptionText),
      ]),
    );
  }
}
