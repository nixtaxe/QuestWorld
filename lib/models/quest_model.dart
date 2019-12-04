class QuestItem {
  int id;
  String name;
  String description;
  int duration;

  QuestItem(this.id, this.name, this.description, this.duration);

  QuestItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    description = json['Description'];
    duration = json['Duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['Duration'] = this.duration;
    return data;
  }
}

class QuestsResponse {
  bool success;
  List<QuestItem> quests;

  QuestsResponse({this.success, this.quests});

  QuestsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['quests'] != null) {
      quests = new List<QuestItem>();
      json['quests'].forEach((v) {
        quests.add(new QuestItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.quests != null) {
      data['quests'] = this.quests.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
