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
  List<int> answers = List<int>();
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
            leading: Icon(Icons.all_out),
            title: Text(question.text),
            onTap: () => {},
          ),
        ),
        buildAnswersList(question.answerList)
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
                leading: Icon(Icons.all_out),
                title: Text(answer.text),
                onTap: () => markAnswer(answer.id),
              ),
            ),
          );
        });
  }

  markAnswer(id) async {
    answers.add(id);
    await tasksBloc.sendAnswers(task.id, id, dateBloc.getCurrentDate());
    Navigator.pop(context);
  }
}