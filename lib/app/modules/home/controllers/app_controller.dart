import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/basket.dart';
import 'package:rxdart/subjects.dart';
class AppController extends GetxController {
  // RxList<CartItemModel> cartItems = RxList<CartItemModel>([]);
  final basketItems=<Basket>[].obs;
  List<TextEditingController> textEditNoteController = [];
// List<Basket> get basketItems => _basketItems.value;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
final BehaviorSubject<String> selectNotificationSubject =BehaviorSubject<String>();
  @override
  void onInit() {
    super.onInit();
    mainLoadLocalNotifications();
    Timer.periodic(Duration(seconds: 20), (timer) async {
      await showNotification();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  Future<void> mainLoadLocalNotifications() async {
    AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings initializationSettingsIOs = IOSInitializationSettings();
    InitializationSettings initSetttings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOs);
    /* await flutterLocalNotificationsPlugin.initialize(initSetttings,onSelectNotification: (String order_id) async {
      if (order_id != null) {
        debugPrint('notification payload: $order_id');
        Get.toNamed(Routes.MyOrderDetails,arguments:int.parse(order_id));
        // onSelectNotification(order_id);
      }

      selectNotificationSubject.add(order_id);
    });*/
    // flutterLocalNotificationsPlugin.initialize(initSetttings,onSelectNotification: onSelectNotification);
  }
//NotificationModel notificationModel
  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '1234', 'status Traking', 'status Traking description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker1',
      // color:Colors.,

    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    var title='order_satatus_changed';
    var statustext='body';
    var smsBody='your_order_change_body';

    await flutterLocalNotificationsPlugin.show(1, title, smsBody, platformChannelSpecifics, payload: '1');
  }

}
