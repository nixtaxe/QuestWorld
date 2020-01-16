import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:quest_world/blocks/user_block.dart';
import 'package:quest_world/models/task_model.dart';

import '../url_strings.dart' as UrlStrings;
import '../integer_constants.dart' as IntConst;
import '../user/user_strings.dart' as UserStrings;
import 'tasks_strings.dart' as TasksStrings;

class TasksRepository {
  Dio _client;
  String token;

  TasksRepository() {
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
    options.queryParameters.addAll({UserStrings.token: token});
    return options;
  }

  responseInterceptor(Response response) {
    return response;
  }

  errorInterceptor(DioError dioError) {
    return dioError;
  }

  Future<TasksResponse> getCurrentTasks(int questId,
      {String active, String started}) async {
    final params = {
      TasksStrings.quest: questId,
      TasksStrings.active: active ?? TasksStrings.none,
      TasksStrings.started: started ?? TasksStrings.none
    };
    try {
      final response = await _client.get(UrlStrings.getCurrentTasks,
          queryParameters: params);
      return TasksResponse.fromJson(response.data);
    }
    catch (e) {
      throw e;
    }

  }
}
