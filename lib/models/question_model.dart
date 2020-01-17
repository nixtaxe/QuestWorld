class QuestionResponse {
  List<Question> question;

  QuestionResponse({this.question});

  QuestionResponse.fromJson(Map<String, dynamic> json) {
    if (json['Question'] != null) {
      question = new List<Question>();
      json['Question'].forEach((v) {
        question.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.question != null) {
      data['Question'] = this.question.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  int id;
  String text;
  int choice;
  List<AnswerItem> answerList;

  Question({this.id, this.text, this.answerList});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['Text'];
    if (json['AnswerList'] != null) {
      answerList = new List<AnswerItem>();
      json['AnswerList'].forEach((v) {
        answerList.add(new AnswerItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Text'] = this.text;
    if (this.answerList != null) {
      data['AnswerList'] = this.answerList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnswerItem {
  int id;
  String text;
  bool isChecked = false;

  AnswerItem({this.id, this.text});

  AnswerItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['Text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Text'] = this.text;
    return data;
  }
}