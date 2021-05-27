import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/data/models/basket.dart';
class CardProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<List<Basket>> postOrder(data) async {
   try{
     Response response = await post("https://eshtri.net/resturant_bukhari/api/v1/sales/postsales?api-key=${MrConfig.mr_api_key}",data);
     if (response.status.hasError) {
       return Future.error(response.statusText);
     } else {
       return response.body['data'];

     }
   }catch(exception){
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
