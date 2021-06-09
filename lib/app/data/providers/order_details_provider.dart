import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/core/values/mr_url.dart';
import 'package:waiter/app/data/models/pagination_filter.dart';
import 'package:waiter/app/data/models/product.dart';

class OrderDetailsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<dynamic> getProduct(String catId,PaginationFilter filter) async {
    print(filter.offset);
    print('filter.limit');
    print(filter.limit);
    final String productUrl="${MrUrl.get_product_list_url}products?category_code=${catId}&;start=${filter.offset}&limit=${filter.limit}&api-key=${MrConfig.mr_api_key}";
    print(productUrl);
    print('productUrl');
    Response response = await  get(productUrl);
    print(response.body['total']);
    print('response.body');
       if (response.statusCode == 200 && response.body['status'] != false) {
      return productFromJson(response.body['data']);
    } else {
      // return Future.error(response.statusText);
      return null;
    }
  }
}
