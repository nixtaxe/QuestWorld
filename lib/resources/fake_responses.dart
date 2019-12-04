import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quest_world/models/quest_model.dart';

Future<QuestsResponse> getActiveQuests() async {
  final jsonString = await rootBundle.loadString("assets/fake_json/active_quests.json");
  return QuestsResponse.fromJson(json.decode(jsonString));
}