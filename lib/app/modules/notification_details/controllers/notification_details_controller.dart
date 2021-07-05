import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/notification.dart';
import 'package:waiter/app/data/providers/notifications_provider.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
class NotificationDetailsController extends GetxController {
final appController=Get.find<AppController>();
  String id;
  var isLoading = true.obs;
  final _notification = NotificationModel().obs;
  NotificationModel get notification=>_notification.value;
  String comment="";
  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null){
      id= Get?.arguments;
      getSingleNotification(id);
     print(id);
     print('id============');
    }
    print(notification.id);
    print(notification.id);
  }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  Future<void> getSingleNotification(String id) async {
    try {
      isLoading(true);
      var notificationValue = await NotificationsProvider().getOneNotification(id);
      if (notificationValue != null) {
        _notification.value=notificationValue;
        comment=notification.comment;
        print(notification.isread);
        print('notification.isread==============');
        // appController.postIsTouched(notification);
        htmlData(notification.comment);
      }else{
        _notification.value=null;
      }
    } finally {
      isLoading(false);
    }
  }
Widget htmlComment;
 void htmlData(String value){
   htmlComment = Html( data:value,);
  }
}
