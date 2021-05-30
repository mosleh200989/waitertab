import 'dart:convert';

import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/data/models/basket.dart';
import 'package:waiter/app/data/models/sales.dart';
class CardProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<Sales> postSales(Sales sales) async {
    try
    {
      final String postUrl="${MrConfig.base_app_url}resturant_bukhari/api/v1/sales/postsales?api-key=${MrConfig.mr_api_key}";
      print(sales.toMap());
      print('===sales=====');
      Response response = await post(postUrl,sales.toMap());

      print(response.body);
      print('response.body');

      // var returnData=json.decode(response.body);
      // print(returnData);
      // print('returnData');
      if (response.statusCode == 200 ) {
        // print(jsonDecode(userData['data']));
        print('decode');
        // print(jsonEncode(userData['data']));
        return response.body;
      } else {
        return Future.error(response.statusText);
      }
    }
    catch(exception)
    {
      return Future.error(exception.toString());
    }

  }

  /*//Save Data
  Future<String> saveTask(Map data) async {
    try
    {
      final response = await post(
          "http://192.168.43.152:81/TodoApp/public/api/saveTask",data);
      if (response.status.hasError) {
        return Future.error(response.statusText);
      } else {
        return  response.body['result'];
      }
    }
    catch(exception)
    {
      return Future.error(exception.toString());
    }

  }*/

  Future<Response<Basket>> postCity(body) =>
      post<Basket>('http://192.168.0.101:3000/items', body,
          decoder: (obj) => Basket.fromJson(obj));
}
