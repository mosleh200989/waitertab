import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/data/models/user_db.dart';

class MyUserProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  //Save Data
  Future<UserDb> postLogin(UserDb userDb) async {
    try
    {
      Response response = await post("${MrConfig.base_app_url}resturant_bukhari/api/v1/login/checkLogin",userDb.toMap());
      var userData=json.decode(response.body);
      if (response.statusCode == 200 && userData['status']==true) {
        // print(jsonDecode(userData['data']));
        print('decode');
        // print(jsonEncode(userData['data']));
        setCurrentUser(userData['data']);
        return UserDb.fromJSON(userData['data']);
      } else {
        return Future.error(response.statusText);
      }
    }
    catch(exception)
    {
      return Future.error(exception.toString());
    }

  }

  void setCurrentUser(jsonString) async {
    try {
      if (jsonString != null) {
        print(jsonString);
        print('jsonString');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('current_user',  json.encode(jsonString));
      }
    } catch (e) {
      throw new Exception(e);
    }
  }
}
