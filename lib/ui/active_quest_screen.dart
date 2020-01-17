import 'package:flutter/material.dart';
import 'package:quest_world/blocs/quests_bloc.dart';
import 'package:quest_world/blocs/tasks_bloc.dart';
import 'package:quest_world/models/quest_model.dart';
import 'package:quest_world/models/task_model.dart';
import 'package:quest_world/ui/base_widgets/scaffold_wrapper.dart';
import 'package:quest_world/ui/task_description_screen.dart';
import 'package:toast/toast.dart';

class ActiveQuestScreen extends StatefulWidget {
  final quest;

  ActiveQuestScreen({this.quest});

  @override
  State<StatefulWidget> createState() => _ActiveQuestScreenState();
}

class _ActiveQuestScreenState extends State<ActiveQuestScreen> {
  List<TaskItem> tasks;

  QuestItem get quest => widget.quest;

  @override
  void initState() {
    super.initState();
    tasksBloc.getCurrentTasks(quest.id);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            Text(quest.name),
            SizedBox(
              height: 15.0,
            ),
            Text(quest.descriptionText),
            SizedBox(
              height: 15.0,
            ),
            StreamBuilder(
              stream: tasksBloc.currentTasks(),
              builder: (BuildContext context,
                  AsyncSnapshot<TasksResponse> snapshot) {
                if (snapshot.hasError) {
                  Toast.show(snapshot.error.toString(), context,
                      duration: Toast.LENGTH_LONG);
                  return Container(
                    child: Text("Couldn't load quests :("),
                  );
                }

                if (snapshot.hasData) {
                  tasks = snapshot.data.taskList;
                  if (tasks.isEmpty) {
                    return Container(
                      child: Text("No tasks found"),
                    );
                  }
                  return buildTasksList();
                }

                return Expanded(
                    child: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  buildTasksList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: tasks.length,
        itemBuilder: buildTaskItemView);
  }

  Widget buildTaskItemView(context, int id) {
    TaskItem task = tasks[id];
    return Card(
      child: ListTile(
        leading: Icon(Icons.live_help),
        title: Text(task.name),
        subtitle: Text(task.descriptionText),
        onTap: () => openTaskDescription(task),
      ),
    );
  }

  openTaskDescription(task) async {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TaskDescriptionScreen(task: task)))
        .then((value) => setState(() => tasksBloc.getCurrentTasks(quest.id)));
  }
}
