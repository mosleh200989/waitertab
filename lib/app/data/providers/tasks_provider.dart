import 'dart:convert';

import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/data/models/pagination_filter.dart';
import 'package:waiter/app/data/models/task_checkitem.dart';
import 'package:waiter/app/data/models/tasks.dart';

class TasksProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<List<Tasks>> getTasks(PaginationFilter filter) async {
    final String tasksUrl="${MrConfig.base_app_url}resturant_bukhari/api/v1/tasks?status=1&start=${filter.offset}&limit=${filter.limit}&api-key=${MrConfig.mr_api_key}";
    print(tasksUrl);
    print('getTasks tasksUrl');
    Response response = await get(tasksUrl);
    if (response.statusCode == 200 && response.body['data'] !=null) {
      return taskFromJson(response.body['data']);
    } else {
      // return Future.error(response.statusText);
      return [];
    }
  }
  Future<List<Tasks>> getTasksCompleted(PaginationFilter filter) async {
    final String taskssUrl="${MrConfig.base_app_url}resturant_bukhari/api/v1/tasks?status=5&start=${filter.offset}&limit=${filter.limit}&api-key=${MrConfig.mr_api_key}";
    print(taskssUrl);
    print('processing order url');
    Response response = await get(taskssUrl);
    if (response.statusCode == 200 && response.body['data'] !=null) {
      return taskFromJson(response.body['data']);
    } else {
      // return Future.error(response.statusText);
      return [];
    }
  }
  Future<Tasks> updateTask(Tasks task) async {
    try
    {
      final String postUrl="${MrConfig.base_app_url}resturant_bukhari/api/v1/tasks/changetaskstatus";
      Response response = await post(postUrl,task.toMap());
      if (response.statusCode == 200 ) {
        return Tasks.fromJSON(response.body['data']);
      } else {
        return Future.error(response.statusText);
      }
    }
    catch(exception)
    {
      return Future.error(exception.toString());
    }

  }

  Future<Tasks> getOneTasks(String tasksId) async {
    final String tasksSingleUrl="${MrConfig.base_app_url}resturant_bukhari/api/v1/tasks?task_id=$tasksId&api-key=${MrConfig.mr_api_key}";
print(tasksId);
print(tasksSingleUrl);
    Response response = await get(tasksSingleUrl);
       if (response.statusCode == 200 && response.body['data'] !=null ) {
      return Tasks.fromJSON(response.body['data']);
    } else {
      // return Future.error(response.statusText);
      return null;
    }
  }


  Future<dynamic> updateTaskCheckItem(TaskCheckItemModel task) async {
    try{
      final String postUrl="${MrConfig.base_app_url}resturant_bukhari/api/v1/tasks/changecheckliststatus";
      print(postUrl);
      Response response = await post(postUrl,task.toMap());
      if (response.statusCode == 200 && response.body['data'] !=null) {
        return response.body['status'];
      } else {
        return Future.error(response.statusText);
      }

    }
    catch(exception)
    {
      return Future.error(exception.toString());
    }

  }
}
