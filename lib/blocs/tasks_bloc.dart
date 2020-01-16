import 'package:quest_world/models/question_model.dart';
import 'package:quest_world/models/task_model.dart';
import 'package:quest_world/resources/tasks/tasks_repository.dart';
import 'package:rxdart/rxdart.dart';

class TasksBlock {
  final _repository = TasksRepository();

  final _currentTasksFetcher = PublishSubject<TasksResponse>();
  final _questionFetcher = PublishSubject<QuestionResponse>();

  Observable<TasksResponse> currentTasks() => _currentTasksFetcher.stream;
  Observable<QuestionResponse> question() => _questionFetcher.stream;

  getCurrentTasks(int questId, {String active, String started}) async {
    final result = await _repository.getCurrentTasks(questId, active: active, started: started);
    _currentTasksFetcher.sink.add(result);
  }

  getQuestionById(int id) async {
    final result = await _repository.getQuestionById(id);
    _questionFetcher.sink.add(result);
  }

  sendAnswers(int id, params, String date) async {
    await _repository.startTask(id, date);
    await _repository.performTask(id, params, date);
  }

  dispose() {
    _currentTasksFetcher.close();
    _questionFetcher.close();
  }
}

final tasksBloc = TasksBlock();