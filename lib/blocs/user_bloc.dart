import 'package:quest_world/models/token_model.dart';
import 'package:quest_world/models/user_model.dart';
import 'package:quest_world/resources/fake_responses.dart';
import 'package:quest_world/resources/user/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _repository = UserRepository();

  final _tokenFetcher = PublishSubject<bool>();

  Observable<bool> hasToken() => _tokenFetcher.stream;

  checkToken() async {
    final hasToken = await _repository.hasToken();
    _tokenFetcher.sink.add(hasToken);
  }

  Future<bool> login(String username, String password) async {
    TokenResponse token =
        await _repository.login(username: username, password: password);
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
