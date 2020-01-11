import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_world/blocks/quests_block.dart';
import 'package:quest_world/models/quest_model.dart';
import 'package:quest_world/resources/fake_responses.dart';
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(widget.title, style: Theme.of(context).textTheme.title,),
        ),
        StreamBuilder(
            stream: widget.getQuestsStream(),
            builder:
                (BuildContext context, AsyncSnapshot<QuestsResponse> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Container();
              }

              if (snapshot.hasData) {
                quests = snapshot.data.quests;
                return buildQuestListView();
              }

              return Container();
            })
      ],
    );
  }

  openQuestView(quest) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuestDescriptionScreen(quest: quest)));
  }

  Widget buildQuestListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: quests.length,
        itemBuilder: buildQuestItemView);
  }

  Widget buildQuestItemView(context, int id) {
    QuestItem quest = quests[id];
    return Card(
      child: ListTile(
        leading: Icon(Icons.all_out),
        title: Text(quest.name),
        subtitle: Text(quest.description),
        onTap: () => openQuestView(quest),
      ),
    );
  }

//  @override
//  void dispose() {
//    questsBlock.dispose();
//    super.dispose();
//  }
}
