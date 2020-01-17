import 'package:flutter/material.dart';
import 'package:quest_world/blocs/date_bloc.dart';
import 'package:quest_world/blocs/tasks_bloc.dart';
import 'package:quest_world/models/question_model.dart';
import 'package:quest_world/models/task_model.dart';
import 'package:toast/toast.dart';

class QuestionView extends StatefulWidget {
  final task;

  QuestionView({this.task});

  @override
  State<StatefulWidget> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  List<Question> questions;
  TaskItem get task => widget.task;

  @override
  void initState() {
    super.initState();
    tasksBloc.getQuestionById(task.question);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: tasksBloc.question(),
      builder: (BuildContext context, AsyncSnapshot<QuestionResponse> snapshot) {
        if (snapshot.hasError) {
          Toast.show(snapshot.error.toString(), context, duration: Toast.LENGTH_LONG);
        }

        if (snapshot.hasData) {
          questions = snapshot.data.question;
          return buildQuestionsList();
        }

        return Container();
      },
    );
  }

  Widget buildQuestionsList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: questions.length,
        itemBuilder: buildQuestionItemView);
  }

  Widget buildQuestionItemView(context, int id) {
    Question question = questions[id];
    return Column(
      children: <Widget>[
        Card(
          child: ListTile(
            leading: Icon(Icons.help_outline),
            title: Text(question.text),
            onTap: () {},
          ),
        ),
        buildAnswersList(question.answerList),
        buildSaveButton(question.answerList)
      ],
    );
  }

  Widget buildAnswersList(List<AnswerItem> answerList) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: answerList.length,
        itemBuilder: (context, id) {
          AnswerItem answer = answerList[id];
          return Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Card(
              child: ListTile(
                leading: Checkbox(value: answer.isChecked, onChanged: (bool value) {
                  setState(() {
                    answer.isChecked = value;
                  });
                }),
                title: Text(answer.text),
              ),
            ),
          );
        });
  }

  Widget buildSaveButton(List<AnswerItem> answers) {
    return RaisedButton(child: Text("Save"), onPressed: () => saveAnswers(answers),);
  }

  saveAnswers(List<AnswerItem> answers) async {
    List<int> result = List<int>();
    for (AnswerItem x in answers) {
      if (x.isChecked) {
        result.add(x.id);
      }
    }
    final response = await tasksBloc.sendAnswers(task.id, result, dateBloc.getCurrentDate());
    if (response.success) {
      Toast.show("Correct!", context);
      Future.delayed(Duration(milliseconds: 300)).then((value) => Navigator.pop(context));
    } else {
      Toast.show("Wrong. x atempts remain", context, duration: Toast.LENGTH_LONG);
    }
  }
}