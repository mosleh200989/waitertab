
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
    print(response.body);
    if (response.statusCode == 200) {
      return categoriesFromJson(response.body['data']);
    } else {
      // return Future.error(response.statusText);
      return null;
    }
  }


}
