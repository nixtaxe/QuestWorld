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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 6.0,
            child: ListTile(
              leading: Icon(Icons.help_outline),
              title: Text(question.text),
            ),
          ),
          SizedBox(height: 13.0,),
          buildAnswersList(id, question.answerList),
          SizedBox(height: 15.0,),
          buildSaveButton(id, question.answerList)
        ],
      ),
    );
  }

  Widget buildAnswersList(int questionId, List<AnswerItem> answerList) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: answerList.length,
        itemBuilder: (context, id) {
          AnswerItem answer = answerList[id];
          return Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 6.0, bottom: 6.0),
            child: Material(
              elevation: 4.0,
              color: Colors.white,
              child: RadioListTile(
                  title: Text(answer.text),
                  value: answer.id,
                  groupValue: questions[questionId].choice,
                  onChanged: (int value) {
                    setState(() {
                      questions[questionId].choice = value;
                    });
                  }),
            ),
          );
        });
  }

  Widget buildSaveButton(int id, List<AnswerItem> answers) {
    return  MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          "Send answer",
          style: Theme.of(context).textTheme.button,
        ),
      ),
      color: Theme.of(context).accentColor,
      onPressed: () => saveAnswer(questions[id].choice),
    );
  }

  saveAnswer(int id) async {
//    await tasksBloc.sendAnswers(task.id, id, dateBloc.getCurrentDate());
    Toast.show("Cool!", context,);
    await Future.delayed(Duration(milliseconds: 300)).then((value) => Navigator.pop(context));

  }
}
