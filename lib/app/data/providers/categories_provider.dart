
import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/core/values/mr_url.dart';
import 'package:waiter/app/data/models/categories.dart';
class CategoriesProvider extends GetConnect {
  @override
  void onInit() {
  }
  Future<List<Categories>> getCategories() async {
    Response response = await get("${MrUrl.get_categories_list_url}categories?start=0&limit=20&api-key=${MrConfig.mr_api_key}");
    if (response.statusCode == 200) {
      print(response.body['data']);
      return categoriesFromJson(response.body['data']);
    } else {
      // return Future.error(response.statusText);
      return null;
    }
  }
  // Future<List<Todo>> getTodo(var id) async {
  //   try {
  //     Response rsp = await httpClient.get(AppUrl.get_todo, {'current_page': id});
  //     print(rsp.body['data']);
  //     if (rsp.statusCode != 400) {
  //       List<Todo> responseBode = rsp.body['data'] as List<Todo>; // casting type here
  //       return responseBode;
  //     } else {
  //       return rsp.body["response_message"];
  //     }
  //   } catch (exception) {
  //     return Future.error(exception.toString());
  //   }
  // }

}
