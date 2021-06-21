import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/core/values/mr_url.dart';
import 'package:waiter/app/data/models/pagination_filter.dart';
import 'package:waiter/app/data/models/product.dart';
import 'package:waiter/app/global_widgets/helpers.dart';

class OrderDetailsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<dynamic> getProduct(String catId,PaginationFilter filter) async {
    final String productUrl="${MrUrl.get_product_list_url}products?category_code=${catId}&start=${filter.offset}&limit=${filter.limit}&api-key=${MrConfig.mr_api_key}";
  print(productUrl);
    Response response = await  get(productUrl);
       if (response.statusCode == 200 && response.body['status'] != false  && response.body['data'] !=null) {
      return productFromJson(response.body['data']);
    } else {
         Helpers.showSnackbar(title:'error'.tr,message: 'No_more_items'.tr);
      // return Future.error(response.statusText);
      return null;
    }
  }
}
