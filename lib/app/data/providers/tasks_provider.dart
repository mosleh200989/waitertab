import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/data/models/Task.dart';

class TasksProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<List<Task>> getTasks() async {
    // https://eshtri.net/resturant_bukhari/api/v1/tasks?status=1&start=0&limit=10&api-key=ggsk4wkssoc4sccgskggssws04gc4gokc4g4gokw
    final String taskssUrl="${MrConfig.base_app_url}resturant_bukhari/api/v1/tasks?status=1&start=0&limit=10&api-key=${MrConfig.mr_api_key}";
    print(taskssUrl);
    print('processing order url');
    Response response = await get(taskssUrl);
    // print(response.body);
    // print("response.body");
    // print(response.body['data']);
    if (response.statusCode == 200 && response.body['data'] !=null) {
      return taskFromJson(response.body['data']);
    } else {
      // return Future.error(response.statusText);
      return [];
    }
  }
  Future<List<Task>> getTasksCompleted() async {
    final String taskssUrl="${MrConfig.base_app_url}resturant_bukhari/api/v1/tasks?status=1&start=0&limit=10&api-key=${MrConfig.mr_api_key}";
    print(taskssUrl);
    print('processing order url');
    Response response = await get(taskssUrl);
    // print(response.body);
    // print("response.body");
    // print(response.body['data']);
    if (response.statusCode == 200 && response.body['data'] !=null) {
      return taskFromJson(response.body['data']);
    } else {
      // return Future.error(response.statusText);
      return [];
    }
  }
  Future<Task> updateTask(Task task) async {
    try
    {
      final String postUrl="${MrConfig.base_app_url}resturant_bukhari/api/v1/tasks/changetaskstatus";
      Response response = await post(postUrl,task.toMap());
      if (response.statusCode == 200 ) {
        return Task.fromJSON(response.body['data']);
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
