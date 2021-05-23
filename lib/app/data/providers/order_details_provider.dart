import 'package:get/get.dart';
import 'package:waiter/app/data/models/product.dart';

class OrderDetailsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<List<Product>> getProduct(String catId) async {
    print(catId);
    print('catId====');
    Response response = await  get("https://eshtri.net/resturant_bukhari/api/v1/products?category_code=${catId}&;start=10&limit=10&api-key=ggsk4wkssoc4sccgskggssws04gc4gokc4g4gokw");
    print(response.body['data']);
    print('response product');
    if (response.statusCode == 200) {
      return productFromJson(response.body['data']);
    } else {
      // return Future.error(response.statusText);
      return null;
    }
  }
}
