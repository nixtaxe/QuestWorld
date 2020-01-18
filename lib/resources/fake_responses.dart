import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quest_world/models/quest_model.dart';
import 'package:quest_world/models/question_model.dart';
import 'package:quest_world/models/task_model.dart';
import 'package:quest_world/models/user_model.dart';

Future<QuestsResponse> getActiveQuests() async {
  final jsonString = await rootBundle.loadString("assets/fake_json/active_quests.json");
  return QuestsResponse.fromJson(json.decode(jsonString));
}

Future<TasksResponse> getCurrentTaskList(int id) async {
  var jsonString;
  if (id == 1) {
    jsonString = await rootBundle.loadString("assets/fake_json/task1.json");
  }
  if (id == 2) {
    jsonString = await rootBundle.loadString("assets/fake_json/task2.json");
  }
  return TasksResponse.fromJson(json.decode(jsonString));
}

Future<UserRequest> getUser() async {
  final jsonString = await rootBundle.loadString("assets/fake_json/login.json");
  return UserRequest.fromJson(json.decode(jsonString));
}

Future<QuestionResponse> getQuestion(int id) async {
  var jsonString;
  if (id == 2) {
    jsonString = await rootBundle.loadString("assets/fake_json/questions.json");
  }
//  if (id == 1) {
//    jsonString = await rootBundle.loadString("assets/fake_json/choice.json");
//  }
  return QuestionResponse.fromJson(json.decode(jsonString));
}