class TasksResponse {
  List<TaskItem> taskList;

  TasksResponse({this.taskList});

  TasksResponse.fromJson(Map<String, dynamic> json) {
    if (json['TaskList'] != null) {
      taskList = new List<TaskItem>();
      json['TaskList'].forEach((v) {
        taskList.add(new TaskItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.taskList != null) {
      data['TaskList'] = this.taskList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskItem {
  int id;
  String name;
  String descriptionText;
  String type;
  String startTime;
  String finishTime;
  int duration;
  bool autostart;
  int distance;
  String qRCode;
  int question;
  String link;
  int x;
  int y;
  bool active;
  String startDate;
  String finishDate;
  bool started;
  int quest;

  TaskItem(
      {this.id,
        this.name,
        this.descriptionText,
        this.type,
        this.startTime,
        this.finishTime,
        this.duration,
        this.autostart,
        this.distance,
        this.qRCode,
        this.question,
        this.link,
        this.x,
        this.y,
        this.active,
        this.startDate,
        this.finishDate,
        this.started,
        this.quest});

  TaskItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    descriptionText = json['DescriptionText'];
    type = json['Type'];
    startTime = json['StartTime'];
    finishTime = json['FinishTime'];
    duration = json['Duration'];
    autostart = json['Autostart'];
    distance = json['Distance'];
    qRCode = json['QRCode'];
    question = json['Question'];
    link = json['Link'];
    x = json['X'];
    y = json['Y'];
    active = json['Active'];
    startDate = json['StartDate'] is int ? "" : json['StartDate'];
    finishDate = json['FinishDate'] is int ? "" : json['FinishDate'];
    started = json['Started'];
    quest = json['Quest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['DescriptionText'] = this.descriptionText;
    data['Type'] = this.type;
    data['StartTime'] = this.startTime;
    data['FinishTime'] = this.finishTime;
    data['Duration'] = this.duration;
    data['Autostart'] = this.autostart;
    data['Distance'] = this.distance;
    data['QRCode'] = this.qRCode;
    data['Question'] = this.question;
    data['Link'] = this.link;
    data['X'] = this.x;
    data['Y'] = this.y;
    data['Active'] = this.active;
    data['StartDate'] = this.startDate;
    data['FinishDate'] = this.finishDate;
    data['Started'] = this.started;
    data['Quest'] = this.quest;
    return data;
  }
}


class PerformTaskResponse {
  bool status;
  bool success;
  bool finished;
  TaskInfo taskInfo;
  List<TaskItem> nextTaskList;

  PerformTaskResponse(
      {this.status,
        this.success,
        this.finished,
        this.taskInfo,
        this.nextTaskList});

  PerformTaskResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    success = json['Success'];
    finished = json['Finished'];
    taskInfo = json['TaskInfo'] != null
        ? new TaskInfo.fromJson(json['TaskInfo'])
        : null;
    if (json['NextTaskList'] != null) {
      nextTaskList = new List<TaskItem>();
      json['NextTaskList'].forEach((v) {
        nextTaskList.add(new TaskItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Success'] = this.success;
    data['Finished'] = this.finished;
    if (this.taskInfo != null) {
      data['TaskInfo'] = this.taskInfo.toJson();
    }
    if (this.nextTaskList != null) {
      data['NextTaskList'] = this.nextTaskList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskInfo {
  String startDate;
  String finishDate;
  int answer;
  bool success;
  int distance;
  int attempts;

  TaskInfo(
      {this.startDate,
        this.finishDate,
        this.answer,
        this.success,
        this.distance,
        this.attempts});

  TaskInfo.fromJson(Map<String, dynamic> json) {
    startDate = json['StartDate'];
    finishDate = json['FinishDate'];
    answer = json['Answer'];
    success = json['Success'];
    distance = json['Distance'];
    attempts = json['Attempts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StartDate'] = this.startDate;
    data['FinishDate'] = this.finishDate;
    data['Answer'] = this.answer;
    data['Success'] = this.success;
    data['Distance'] = this.distance;
    data['Attempts'] = this.attempts;
    return data;
  }
}
