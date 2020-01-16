import 'package:flutter/material.dart';
import 'package:quest_world/blocs/date_bloc.dart';
import 'package:quest_world/blocs/quests_bloc.dart';
import 'package:quest_world/models/quest_model.dart';
import 'package:quest_world/ui/base_widgets/scaffold_wrapper.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

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
        FlatButton(
          child: Text("Join Quest"),
          onPressed: () => joinQuest(context),
        )
      ]),
    );
  }

  joinQuest(context) async {
    try {
      final result = await questsBlock.joinQuest(
          quest.id, dateBloc.getCurrentDate());
      Toast.show("$result", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } catch (e) {
      Toast.show(e.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
