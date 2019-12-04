import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_world/blocks/quests_block.dart';
import 'package:quest_world/models/quest_model.dart';
import 'package:quest_world/resources/fake_responses.dart';

class QuestsTab extends StatefulWidget {
  final title;
  final loadQuests;
  final getQuestsStream;

  QuestsTab(this.loadQuests, this.getQuestsStream, this.title);

  @override
  State<QuestsTab> createState() => _QuestTabState();
}

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
        Text(widget.title),
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

  Widget buildQuestListView() {
    return ListView.builder(shrinkWrap: true, itemBuilder: buildQuestItemView);
  }

  Widget buildQuestItemView(context, int id) {
    QuestItem quest = quests[id];
    return Card(
      child: ListTile(
        leading: Icon(Icons.all_out),
        title: Text(quest.name),
        subtitle: Text(quest.description),
      ),
    );
  }

  @override
  void dispose() {
    questsBlock.dispose();
    super.dispose();
  }
}
