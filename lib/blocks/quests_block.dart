import 'package:quest_world/models/quest_model.dart';
import 'package:quest_world/resources/fake_responses.dart';
import 'package:quest_world/resources/quests/quests_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../resources/quests/quests_strings.dart' as QuestsStrings;

class QuestsBlock {
  final _repository = QuestsRepository();
  
  final _activeQuestsFetcher = PublishSubject<QuestsResponse>();
  final _finishedQuestsFetcher = PublishSubject<QuestsResponse>();
  final _abandonedQuestsFetcher = PublishSubject<QuestsResponse>();
  final _availableQuestsFetcher = PublishSubject<QuestsResponse>();

  Observable<QuestsResponse> activeQuests() => _activeQuestsFetcher.stream;
  Observable<QuestsResponse> finishedQuests() => _finishedQuestsFetcher.stream;
  Observable<QuestsResponse> abandonedQuests() => _abandonedQuestsFetcher.stream;
  Observable<QuestsResponse> availableQuests() => _availableQuestsFetcher.stream;

  //TODO fetch real quests based on type (active, abandoned, finished)
  fetchActiveQuests() async {
//    QuestsResponse quests = await getActiveQuests();
    QuestsResponse quests = await _repository.getQuestsByStatus(QuestsStrings.active);
    _activeQuestsFetcher.sink.add(quests);
  }

  fetchFinishedQuests() async {
    QuestsResponse quests = await _repository.getQuestsByStatus(QuestsStrings.finished);
    _finishedQuestsFetcher.sink.add(quests);
  }

  fetchAbandonedQuests() async {
    QuestsResponse quests = await _repository.getQuestsByStatus(QuestsStrings.abandoned);
    _abandonedQuestsFetcher.sink.add(quests);
  }

  fetchAvailableQuests() async {
    QuestsResponse quests = await _repository.getAvailableQuests();
    _availableQuestsFetcher.sink.add(quests);
  }

  Future<bool> joinQuest(int id, String date) async {
    return await _repository.joinQuest(id, date);
  }

  dispose() {
    _activeQuestsFetcher.close();
    _finishedQuestsFetcher.close();
    _abandonedQuestsFetcher.close();
  }
}
//TODO add fetching tasks
//TODO add starting task
final questsBlock = QuestsBlock();
