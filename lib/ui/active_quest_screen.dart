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
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image(image: AssetImage('assets/images/image${quest.id}.jpg'), height: 150.0,),
                      SizedBox(height: 5.0,),
                      Text(
                        quest.name,
                        style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15.0,),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
      child: Card(
        elevation: 4.0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: ExactAssetImage('assets/images/${task.type}.png'),
          ),
          title: Text(task.name),
          onTap: () => openTaskDescription(task),
        ),
      ),
    );
  }

  openTaskDescription(task) async {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TaskDescriptionScreen(task: task)))
        .then((value) {
      tasksBloc.getCurrentTasks(quest.id);
      setState(() {});
    });
  }
}
