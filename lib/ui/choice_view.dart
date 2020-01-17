import 'package:flutter/material.dart';
import 'package:quest_world/blocs/date_bloc.dart';
import 'package:quest_world/blocs/tasks_bloc.dart';
import 'package:quest_world/models/question_model.dart';
import 'package:quest_world/models/task_model.dart';
import 'package:toast/toast.dart';

class ChoiceView extends StatefulWidget {
  final task;

  ChoiceView({this.task});

  @override
  State<StatefulWidget> createState() => _ChoiceViewState();
}

class _ChoiceViewState extends State<ChoiceView> {
  List<Question> questions;

  TaskItem get task => widget.task;

  @override
  void initState() {
    super.initState();
    tasksBloc.getQuestionById(task.question);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: tasksBloc.question(),
        builder:
            (BuildContext context, AsyncSnapshot<QuestionResponse> snapshot) {
          if (snapshot.hasError) {
            Toast.show(snapshot.error.toString(), context,
                duration: Toast.LENGTH_LONG);
          }

          if (snapshot.hasData) {
            questions = snapshot.data.question;
            return buildQuestionsList();
          }

          return Container();
        },
      ),
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
    if (question.choice == null) {
      question.choice = question.answerList.first.id;
    }
    return Column(
      children: <Widget>[
        Card(
          child: ListTile(
            leading: Icon(Icons.help_outline),
            title: Text(question.text),
            onTap: () {},
          ),
        ),
        buildAnswersList(id, question.answerList),
        buildSaveButton(id, question.answerList)
      ],
    );
  }

  Widget buildAnswersList(int questionId, List<AnswerItem> answerList) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: answerList.length,
        itemBuilder: (context, id) {
          AnswerItem answer = answerList[id];
          return Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: RadioListTile(
                title: Text(answer.text),
                value: answer.id,
                groupValue: questions[questionId].choice,
                onChanged: (int value) {
                  setState(() {
                    questions[questionId].choice = value;
                  });
                }),
          );
        });
  }

  Widget buildSaveButton(int id, List<AnswerItem> answers) {
    return RaisedButton(
      child: Text("Save"),
      onPressed: () => saveAnswer(questions[id].choice),
    );
  }

  saveAnswer(int id) async {
    await tasksBloc.sendAnswers(task.id, id, dateBloc.getCurrentDate());
    Navigator.pop(context);
  }
}
