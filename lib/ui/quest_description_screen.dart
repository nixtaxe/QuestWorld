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
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Color(0xFFe8f4f8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColorDark,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/image${quest.id}.jpg'),
                        height: 300.0,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        quest.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        quest.descriptionText,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Join quest",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                color: Theme.of(context).accentColor,
                onPressed: () => joinQuest(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  joinQuest(context) async {
    try {
      final success = true;
//          await questsBlock.joinQuest(quest.id, dateBloc.getCurrentDate());
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
