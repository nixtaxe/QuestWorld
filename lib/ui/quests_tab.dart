import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_world/blocs/quests_bloc.dart';
import 'package:quest_world/models/quest_model.dart';
import 'package:quest_world/resources/fake_responses.dart';
import 'package:quest_world/ui/active_quest_screen.dart';
import 'package:quest_world/ui/quest_description_screen.dart';

class QuestsTab extends StatefulWidget {
  final title;
  final loadQuests;
  final getQuestsStream;

  QuestsTab({this.loadQuests, this.getQuestsStream, this.title});

  @override
  State<QuestsTab> createState() => _QuestTabState();
}

//TODO change quest item screen based on type of the tab
class _QuestTabState extends State<QuestsTab> {
  List<QuestItem> quests;

  @override
  void initState() {
    super.initState();

    widget.loadQuests();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color(0xFFe8f4f8),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.title.copyWith(color: Theme.of(context).accentColor, fontWeight: FontWeight.w400),
            ),
          ),
          StreamBuilder(
              stream: widget.getQuestsStream(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuestsResponse> snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    child: Center(
                      child: Text(snapshot.error.toString()),
                    ),
                  );
                }

                if (snapshot.hasData) {
                  quests = snapshot.data.questList;
                  if (quests.length == 0) {
                    return Expanded(
                      child: Container(
                        child: Center(
                          child: Text("No quests found"),
                        ),
                      ),
                    );
                  }
                  return buildQuestListView();
                }

                return Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: CircularProgressIndicator()),
                  ),
                );
              })
        ],
      ),
    );
  }

  openQuestView(quest) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => quest.status != null
                ? QuestDescriptionScreen(quest: quest)
                : ActiveQuestScreen(
                    quest: quest,
                  ))).then((value) => widget.loadQuests());
  }

  Widget buildQuestListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: quests.length,
        itemBuilder: buildQuestItemView);
  }

  Widget buildQuestItemView(context, int id) {
    QuestItem quest = quests[id];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Card(
        elevation: 4.0,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: ExactAssetImage('assets/images/image${id + 1}.jpg'),
            ),
            title: Text(quest.name, style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.w400),),
            onTap: () => openQuestView(quest),
          ),
        ),
      ),
    );
  }

//  @override
//  void dispose() {
//    questsBlock.dispose();
//    super.dispose();
//  }
}
