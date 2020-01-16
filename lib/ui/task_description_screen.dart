import 'package:flutter/material.dart';
import 'package:quest_world/models/task_model.dart';
import 'package:quest_world/ui/base_widgets/scaffold_wrapper.dart';
import 'package:quest_world/ui/question_view.dart';

import 'const_values.dart' as ConstValues;

class TaskDescriptionScreen extends StatefulWidget {
  final task;

  TaskDescriptionScreen({this.task});

  @override
  State<StatefulWidget> createState() => _TaskDescriptionScreenState();
}

class _TaskDescriptionScreenState extends State<TaskDescriptionScreen> {
  TaskItem get task => widget.task;

  @override
  Widget build(BuildContext context) {
    Widget taskBody = (task.type == ConstValues.questionsType) ||
            (task.type == ConstValues.choiceType)
        ? QuestionView(task: task)
        : Container(
            child: Text("Unknown"),
          );

    return ScaffoldWrapper(
      child: Column(
        children: <Widget>[
          Text(task.name),
          Text(task.descriptionText),
          taskBody,
        ],
      ),
    );
  }
}
