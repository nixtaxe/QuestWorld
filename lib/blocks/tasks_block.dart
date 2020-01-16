import 'package:quest_world/models/task_model.dart';
import 'package:quest_world/resources/tasks/tasks_repository.dart';
import 'package:rxdart/rxdart.dart';

class TasksBlock {
  final _repository = TasksRepository();

  final _currentTasksFetcher = PublishSubject<TasksResponse>();

  Observable<TasksResponse> currentTasks() => _currentTasksFetcher.stream;

  getCurrentTasks(int questId, {String active, String started}) async {
    final result = await _repository.getCurrentTasks(questId, active: active, started: started);
    _currentTasksFetcher.sink.add(result);
  }

  dispose() {
    _currentTasksFetcher.close();
  }
}

final tasksBloc = TasksBlock();