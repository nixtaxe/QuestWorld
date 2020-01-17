import 'package:quest_world/blocs/quests_bloc.dart';
import 'package:quest_world/models/quest_model.dart';
import 'package:quest_world/models/start_state_model.dart';
import 'package:quest_world/models/token_model.dart';
import 'package:quest_world/models/user_model.dart';
import 'package:quest_world/resources/url_strings.dart';
import 'package:quest_world/resources/user/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _repository = UserRepository();

  final _tokenFetcher = PublishSubject<StartState>();

  Observable<StartState> hasToken() => _tokenFetcher.stream;

  Future<StartState> checkToken() async {
    final hasToken = await _repository.hasToken();
    final QuestsResponse quests = await questsBlock.fetchActiveQuests();
    final hasActiveQuests = !quests.questList.isEmpty;
    final result = StartState(hasToken: hasToken, hasActiveQuests: hasActiveQuests);
    _tokenFetcher.sink.add(result);
    return result;
  }

  Future<bool> login(String username, String password) async {
    TokenResponse token =
        await _repository.login(username: username, password: password);
    return token.token != null;
  }

  Future<bool> register(String username, String password) async {
    TokenResponse token = await _repository.register(username: username, password: password);
    return token.token != null;
  }

  Future<String> getToken() async {
    return await _repository.getToken();
  }

  deleteToken() async {
    await _repository.deleteToken();
  }

  dispose() {
    _tokenFetcher.close();
  }
}

final userBloc = UserBloc();
