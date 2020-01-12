import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:quest_world/models/quest_model.dart';

import '../../blocks/user_block.dart';

import '../url_strings.dart' as UrlStrings;
import '../integer_constants.dart' as IntConst;
import '../user/user_strings.dart' as UserStrings;
import 'quests_strings.dart' as QuestsStrings;

class QuestsRepository {
  Dio _client;
  String token;

  QuestsRepository() {
    BaseOptions options = BaseOptions(
      baseUrl: UrlStrings.baseUrl,
      connectTimeout: IntConst.connectTimeout,
      receiveTimeout: IntConst.receiveTimeout,
    );

    _client = Dio(options);

    _client.interceptors.add(DioCacheManager(CacheConfig(
            baseUrl: UrlStrings.baseUrl,
            defaultMaxAge: Duration(days: IntConst.maxCacheAge)))
        .interceptor);
    _client.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) => requestInterceptor(options),
        onResponse: (Response response) => responseInterceptor(response),
        onError: (DioError dioError) => errorInterceptor(dioError),
    ));
    _client.interceptors.add(LogInterceptor());
  }

  requestInterceptor(RequestOptions options) async {
    token = await userBloc.getToken();
    options.queryParameters.addAll({UserStrings.token : token});
    return options;
  }

  responseInterceptor(Response response) {
    return response;
  }

  errorInterceptor(DioError dioError) {
    return dioError;
  }

  Future<QuestsResponse> getQuestsByStatus(String status) async {
    final params = {QuestsStrings.status: status};
    final response = await _client.get(UrlStrings.getQuestsByUserUrl, queryParameters: params);
    if (response.statusCode == IntConst.ok) {
      return QuestsResponse.fromJson(response.data);
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<QuestsResponse> getAvailableQuests() async {
    final response = await _client.get(UrlStrings.getAvailableQuestsUrl);
    if (response.statusCode == IntConst.ok) {
      return QuestsResponse.fromJson(response.data);
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
