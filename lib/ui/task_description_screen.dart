import 'package:flutter/material.dart';
import 'package:quest_world/models/task_model.dart';
import 'package:quest_world/ui/base_widgets/scaffold_wrapper.dart';
import 'package:quest_world/ui/qr_view.dart';
import 'package:quest_world/ui/question_view.dart';

import 'choice_view.dart';
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
    Widget taskBody = (task.type == ConstValues.questionsType)
        ? QuestionView(task: task)
        : (task.type == ConstValues.choiceType)
            ? ChoiceView(task: task)
            : (task.type == "QR")
                ? QrView(
                    task: task,
                  )
                : Container(
                    child: Text("Unknown"),
                  );

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Color(0xFFe8f4f8),
          child: Column(
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColorDark,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        task.name,
                        style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      task.descriptionText != "" ? Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          task.descriptionText,
                          style: TextStyle(color: Colors.white),
                        ),
                      ) : Container(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              taskBody,
            ],
          ),
        ),
      ),
    );
  }
}
