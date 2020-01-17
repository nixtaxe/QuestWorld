import 'package:flutter/material.dart';
import 'package:quest_world/blocs/date_bloc.dart';
import 'package:quest_world/blocs/quests_bloc.dart';
import 'package:quest_world/models/quest_model.dart';
import 'package:quest_world/ui/active_quest_screen.dart';
import 'package:quest_world/ui/base_widgets/scaffold_wrapper.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class QuestDescriptionScreen extends StatelessWidget {
  final QuestItem quest;

  QuestDescriptionScreen({this.quest});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 15.0,
          ),
          Text(quest.name),
          SizedBox(
            height: 5.0,
          ),
          Text(quest.descriptionText),
          SizedBox(
            height: 5.0,
          ),
          RaisedButton(
            child: Text("Join Quest"),
            onPressed: () => joinQuest(context),
          )
        ]),
      ),
    );
  }

  joinQuest(context) async {
    try {
      final success =
          await questsBlock.joinQuest(quest.id, dateBloc.getCurrentDate());
      if (success) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ActiveQuestScreen(
                      quest: quest,
                    )));
      }
    } catch (e) {
      Toast.show(e.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
