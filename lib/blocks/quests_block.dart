import 'package:quest_world/models/quest_model.dart';
import 'package:quest_world/resources/fake_responses.dart';
import 'package:rxdart/rxdart.dart';

class QuestsBlock {
  final _activeQuestsFetcher = PublishSubject<QuestsResponse>();

  Observable<QuestsResponse> activeQuests() => _activeQuestsFetcher.stream;

  fetchActiveQuests() async {
    QuestsResponse quests = await getActiveQuests();
    _activeQuestsFetcher.sink.add(quests);
  }

  dispose() {
    _activeQuestsFetcher.close();
  }
}

final questsBlock = QuestsBlock();
