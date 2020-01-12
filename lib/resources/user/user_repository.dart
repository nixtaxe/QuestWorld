import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quest_world/models/token_model.dart';
import 'package:quest_world/resources/user/user_api_provider.dart';

import 'user_strings.dart' as UserStrings;

class UserRepository {
  final _userApiProvider = UserApiProvider();

  Future<TokenResponse> login({
    String username,
    String password,
  }) async {
    final token = await _userApiProvider.login(username, password);
    persistToken(token.token);
    return token;
  }

  Future<void> deleteToken() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: UserStrings.token);
    return;
  }

  Future<void> persistToken(String token) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: UserStrings.token, value: token);
    return;
  }

  Future<String> getToken() async {
    final storage = new FlutterSecureStorage();
    final token = await storage.read(key: UserStrings.token);
    return token;
  }

  Future<bool> hasToken() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: UserStrings.token);
    return token != null;
  }
}