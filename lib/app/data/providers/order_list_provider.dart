import 'dart:convert';

import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/core/values/mr_url.dart';
import 'package:waiter/app/data/models/pagination_filter.dart';
import 'package:waiter/app/data/models/sales.dart';
import 'package:waiter/app/global_widgets/helpers.dart';

class OrderListProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<List<Sales>> getSales(PaginationFilter filter) async {
    final String salesUrl="${MrConfig.base_app_url}resturant_bukhari/api/v1/sales?order_status=1&include=items,warehouse,biller,restaurant_table&start=${filter.offset}&limit=${filter.limit}&api-key=${MrConfig.mr_api_key}";

    Response response = await get(salesUrl);
       if (response.statusCode == 200 && response.body['data'] !=null ) {
      return salesFromJson(response.body['data']);
    } else {
      // return Future.error(response.statusText);
      // return [];
      Helpers.showSnackbar(title:'error'.tr,message: 'No_more_items'.tr);
    }
  }
  Future<List<Sales>> getProcessingSales(PaginationFilter filter) async {
    final String salesUrl="${MrConfig.base_app_url}resturant_bukhari/api/v1/sales?order_status=2&include=items,warehouse,biller,restaurant_table&start=${filter.offset}&limit=${filter.limit}&api-key=${MrConfig.mr_api_key}";
    print(salesUrl);
    Response response = await get(salesUrl);
    if (response.statusCode == 200 && response.body['data'] !=null) {
      return salesFromJson(response.body['data']);
    } else {
      // return Future.error(response.statusText);
      Helpers.showSnackbar(title:'error'.tr,message: 'No_more_items'.tr);
      return [];
    }
  }
  Future<List<Sales>> getCancelSales(PaginationFilter filter) async {
    final String salesUrl="${MrConfig.base_app_url}resturant_bukhari/api/v1/sales?order_status=3&include=items,warehouse,biller,restaurant_table&start=${filter.offset}&limit=${filter.limit}&api-key=${MrConfig.mr_api_key}";
     Response response = await get(salesUrl);
    if (response.statusCode == 200 && response.body['data'] !=null) {
      return salesFromJson(response.body['data']);
    } else {
      // return Future.error(response.statusText);
      Helpers.showSnackbar(title:'error'.tr,message: 'No_more_items'.tr);
      return [];
    }
  }
  Future<List<Sales>> getCompleteSales(PaginationFilter filter) async {
    final String salesUrl="${MrConfig.base_app_url}resturant_bukhari/api/v1/sales?order_status=5&include=items,warehouse,biller,restaurant_table&start=${filter.offset}&limit=${filter.limit}&api-key=${MrConfig.mr_api_key}";
    print(salesUrl);
    Response response = await get(salesUrl);
    if (response.statusCode == 200 && response.body['data'] !=null) {
      return salesFromJson(response.body['data']);
    } else {
      // return Future.error(response.statusText);
      Helpers.showSnackbar(title:'error'.tr,message: 'No_more_items'.tr);
      return [];
    }
  }
  Future<Sales> getOneSales(String reference,orderStatus) async {
    final String salesSingleUrl="${MrConfig.base_app_url}resturant_bukhari/api/v1/sales?include=items,warehouse,biller,payment,restaurant_table&sales_id=$reference&order_status=$orderStatus&api-key=${MrConfig.mr_api_key}";
      Response response = await get(salesSingleUrl);
    if (response.statusCode == 200 && response.body['status'] !=false) {
      return Sales.fromJSON(response.body);
    } else {
      // return Future.error(response.statusText);
      Helpers.showSnackbar(title:'error'.tr,message: 'No_more_items'.tr);
      return null;
    }
  }
}
