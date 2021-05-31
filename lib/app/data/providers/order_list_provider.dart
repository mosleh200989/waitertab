import 'dart:convert';

import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/core/values/mr_url.dart';
import 'package:waiter/app/data/models/sales.dart';

class OrderListProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  // https://eshtri.net/resturant_bukhari/api/v1/sales?include=items,%20warehouse,%20biller&start=0&limit=10&api-key=ggsk4wkssoc4sccgskggssws04gc4gokc4g4gokw
  Future<List<Sales>> getSales() async {
    final String salesUrl="${MrConfig.base_app_url}resturant_bukhari/api/v1/sales?include=items,warehouse,biller&start=0&limit=10&&api-key=${MrConfig.mr_api_key}";
    print(salesUrl);
    Response response = await get(salesUrl);
    // print(response.body);
    // print("response.body");
    // print(response.body['data']);
    if (response.statusCode == 200) {
      return salesFromJson(response.body['data']);
    } else {
      // return Future.error(response.statusText);
      return null;
    }
  }
  Future<Sales> getOneSales(String reference) async {
    print(reference);
    print('=====reference');
    final String salesSingleUrl="${MrConfig.base_app_url}resturant_bukhari/api/v1/sales?include=items,warehouse,biller,payment&reference=$reference&api-key=${MrConfig.mr_api_key}";
    print(salesSingleUrl);
    Response response = await get(salesSingleUrl);
    // print(response.body);
    // print("response.body");
    // print(response.body['data']);
    if (response.statusCode == 200) {
      return Sales.fromJSON(response.body);
    } else {
      // return Future.error(response.statusText);
      return null;
    }
  }
}
