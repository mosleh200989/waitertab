import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_constants.dart';
import 'package:waiter/app/data/models/basket.dart';
import 'package:rxdart/subjects.dart';
import 'package:waiter/app/data/models/notification.dart';
import 'package:waiter/app/data/models/pagination_filter.dart';
import 'package:waiter/app/data/providers/notifications_provider.dart';
import 'package:waiter/app/global_widgets/helpers.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';
class AppController extends GetxController {
  final authController =Get.find<AuthController>();
  // RxList<CartItemModel> cartItems = RxList<CartItemModel>([]);
  final basketItems=<Basket>[].obs;
  List<TextEditingController> textEditNoteController = [];
// List<Basket> get basketItems => _basketItems.value;
  var notificationList = <NotificationModel>[].obs;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final _paginationFilter = PaginationFilter().obs;
  int get limit => _paginationFilter.value.limit;
  int get offset => _paginationFilter.value.offset;
  @override
  void onInit()async {
    super.onInit();
    _changePaginationFilter(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    await mainLoadLocalNotifications();
    await getAllNotifications(_paginationFilter.value);
    Timer.periodic(Duration(seconds: 10), (timer) async {
      showNotification();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void _changePaginationFilter(int offset, int limit) {
    _paginationFilter.update((val) {
      val.offset = offset;
      val.limit = limit;
    });
  }
  Future<void> getAllNotifications(PaginationFilter filter) async {
    try {
      if(await authController.checkInternetConnectivity()) {
        // isMoreDataAvailable(false);
        // isDataProcessing(true);
        // isLoading(true);
        var notificationValue = await NotificationsProvider().getNotifications(filter);
        if (notificationValue != null) {
          // salesList.assignAll(salesValue);
          // isDataProcessing(false);
          notificationList.addAll(notificationValue);
        }else{
          notificationList.addAll([]);
          print('no items');
        }
      }else{
        Helpers.showSnackbar(title:'error',message: 'error_dialog__no_internet'.tr);
      }
    } finally {
      // isLoading(false);
      // isDataProcessing(false);
    }
  }

  Future<void> mainLoadLocalNotifications() async {
    AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    print(initializationSettingsAndroid.defaultIcon);
    print('defaulticon');
    IOSInitializationSettings initializationSettingsIOs = IOSInitializationSettings();
    InitializationSettings initSetttings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOs);
    await flutterLocalNotificationsPlugin.initialize(initSetttings,onSelectNotification: (String id) async {
      if (id != null) {
        debugPrint('notification payload: $id');
        // Get.toNamed(Routes.MyOrderDetails,arguments:int.parse(order_id));
        // onSelectNotification(order_id);
      }

      // selectNotificationSubject.add(order_id);
    });
    // flutterLocalNotificationsPlugin.initialize(initSetttings,onSelectNotification: onSelectNotification);
  }
//NotificationModel notificationModel
  Future<void> showNotification() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '1234', 'status Traking', 'status Traking description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker1',
      // color:Colors.blueGrey,
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    // var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(Random().nextInt(50), 'title', 'smsBody', platformChannelSpecifics, payload: 'notification clicked!');
  }
}
