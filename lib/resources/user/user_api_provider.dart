import 'package:dio/dio.dart';
import 'package:quest_world/models/token_model.dart';
import 'package:quest_world/models/user_model.dart';

import '../url_strings.dart' as UrlStrings;
import '../integer_constants.dart' as IntConst;

class UserApiProvider {
  Dio _client;

  UserApiProvider() {
    BaseOptions options = BaseOptions(
      baseUrl: UrlStrings.baseUrl,
      connectTimeout: IntConst.connectTimeout,
      receiveTimeout: 3000,
    );

    _client = Dio(options);

    _client.interceptors.add(LogInterceptor());
  }

  Future<TokenResponse> login(String username, String password) async {
    final params = UserRequest(name: username, password: password).toJson();
    final response = await _client.get(UrlStrings.loginUrl, queryParameters: params);
    if (response.statusCode == IntConst.ok) {
      return TokenResponse.fromJson(response.data);
    } else {
      throw Exception(response.statusMessage);
    }
  }
}