import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quest_world/models/quest_model.dart';
import 'package:quest_world/models/user_model.dart';

Future<QuestsResponse> getActiveQuests() async {
  final jsonString = await rootBundle.loadString("assets/fake_json/active_quests.json");
  return QuestsResponse.fromJson(json.decode(jsonString));
}

Future<UserRequest> getUser() async {
  final jsonString = await rootBundle.loadString("assets/fake_json/login.json");
  return UserRequest.fromJson(json.decode(jsonString));
}