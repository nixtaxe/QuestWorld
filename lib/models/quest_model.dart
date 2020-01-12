class QuestsResponse {
  List<QuestItem> questList;

  QuestsResponse({this.questList});

  QuestsResponse.fromJson(Map<String, dynamic> json) {
    if (json['QuestList'] != null) {
      questList = new List<QuestItem>();
      json['QuestList'].forEach((v) {
        questList.add(new QuestItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questList != null) {
      data['QuestList'] = this.questList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestItem {
  int id;
  String name;
  String descriptionText;
  String startDate;
  String finishDate;
  String status;
  Null questStartDate;
  Null questFinishDate;

  QuestItem(
      {this.id,
        this.name,
        this.descriptionText,
        this.startDate,
        this.finishDate,
        this.status,
        this.questStartDate,
        this.questFinishDate});

  QuestItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    descriptionText = json['DescriptionText'];
    startDate = json['StartDate'];
    finishDate = json['FinishDate'];
    status = json['Status'];
    questStartDate = json['QuestStartDate'];
    questFinishDate = json['QuestFinishDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['DescriptionText'] = this.descriptionText;
    data['StartDate'] = this.startDate;
    data['FinishDate'] = this.finishDate;
    data['Status'] = this.status;
    data['QuestStartDate'] = this.questStartDate;
    data['QuestFinishDate'] = this.questFinishDate;
    return data;
  }
}

//TODO change model to real server quest response model
