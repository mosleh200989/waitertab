import 'dart:convert';

import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/core/values/mr_url.dart';
import 'package:waiter/app/data/models/notification.dart';
import 'package:waiter/app/data/models/pagination_filter.dart';
import 'package:waiter/app/data/models/sales.dart';
import 'package:waiter/app/global_widgets/helpers.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';

class NotificationsProvider extends GetConnect {
  final authController =Get.find<AuthController>();
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<List<NotificationModel>> getNotifications(PaginationFilter filter) async {
   final String notificationsUrl="${MrConfig.base_app_url}resturant_salama/api/v1/notifications?start=${filter.offset}&limit=${filter.limit}&api-key=${MrConfig.mr_api_key}&user_id=${authController.currentUser.id}";
     print(notificationsUrl);
     print(notificationsUrl);
    Response response = await get(notificationsUrl);
       if (response.statusCode == 200 && response.body['data'] !=null ) {
      return notificationFromJson(response.body['data']);
       } else {
      return [];
    }

  }


  Future<NotificationModel> getOneNotification(String id) async {
    // https://eshtri.net/resturant_salama/api/v1/notifications/single_notification?api-key=ggsk4wkssoc4sccgskggssws04gc4gokc4g4gokw&id=1

    final String notificationUrl="${MrConfig.base_app_url}resturant_salama/api/v1/notifications/single_notification?api-key=${MrConfig.mr_api_key}&id=$id";
      Response response = await get(notificationUrl);
    if (response.statusCode == 200 && response.body['status'] !=false) {
      return NotificationModel.fromJSON(response.body);
    } else {
      // return Future.error(response.statusText);
      // Helpers.showSnackbar(title:'error'.tr,message: 'No_more_items'.tr);
      return null;
    }
  }
  Future<NotificationModel> showNotification() async {
    final String notificationUrl="${MrConfig.base_app_url}resturant_salama/api/v1/notifications/notifications_alert?api-key=${MrConfig.mr_api_key}&user_id=${authController.currentUser.id}";
    Response response = await get(notificationUrl);
    if (response.statusCode == 200 && response.body['status'] !=false) {
      return NotificationModel.fromJSON(response.body);
    } else {
      return null;
    }
  }
  Future<dynamic> postIsNotified(NotificationModel notificationModel) async {
    try
    {
      print(notificationModel.toMap());
      print('notify data tomap');
      // api/v1/notifications/is_notified?api-key=ggsk4wkssoc4sccgskggssws04gc4gokc4g4gokw
      String postUrl="${MrConfig.base_app_url}resturant_salama/api/v1/notifications/is_notified";
      print(postUrl);
      Response response = await post(postUrl,notificationModel.toMap());
      print(response.body);
      print('response.body');
      if (response.statusCode == 200 && response.body['status']==true) {
        return response.body['status'];
      } else {
        return null;
      }
    }
    catch(exception)
    {
      return Future.error(exception.toString());
    }

  }
  Future<dynamic> postIsRead(NotificationModel notificationModel) async {
    try
    {
      print(notificationModel);
      String postUrl="${MrConfig.base_app_url}resturant_salama/api/v1/notifications/is_touch";
      Response response = await post(postUrl,notificationModel.toMap());
      // var userData=json.decode(response.body);
      print(response.body);
      print('response.body');
      if (response.statusCode == 200 && response.body['status']==true) {
        return response.body['status'];
      } else {
        return null;
      }
    }
    catch(exception)
    {
      return Future.error(exception.toString());
    }

  }
}
