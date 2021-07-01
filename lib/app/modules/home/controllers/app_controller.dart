import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:waiter/app/core/values/mr_constants.dart';
import 'package:waiter/app/data/models/basket.dart';
import 'package:rxdart/subjects.dart';
import 'package:waiter/app/data/models/notification.dart';
import 'package:waiter/app/data/models/pagination_filter.dart';
import 'package:waiter/app/data/providers/notifications_provider.dart';
import 'package:waiter/app/global_widgets/helpers.dart';
import 'package:waiter/app/global_widgets/loading_dialog.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';
import 'package:waiter/app/routes/app_pages.dart';
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
      // showNotification();
      await getAllNotifications(_paginationFilter.value);
      print(authController.currentUser.warehouse_id);
      print('authController.currentUser.warehouse_id');
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
              for(var i=0; i<notificationList.length; i++){
                if(notificationList[i].isread=='0'){
                  await showNotification(notificationList[i]);
                  print(notificationList.length);
                  print(notificationList[i].isread);
                  print('condition is read==');
                }
              }
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
    await flutterLocalNotificationsPlugin.initialize(initSetttings,onSelectNotification: onSelectNotification);
  }
//NotificationModel notificationModel
  Future<dynamic> onSelectNotification(String payload) async {

    /*Do whatever you want to do on notification click. In this case, I'll show an alert dialog*/
if(payload !=null) {
  Get.back();
  Get.toNamed(Routes.NOTIFICATION_DETAILS, arguments: payload);
  print(payload);
  print('payload');
}
  }
  Future<void> showNotification(NotificationModel notificationModel) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '1234', 'status Traking', 'status Traking description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker1',
      // color:Colors.blueGrey,
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(int.parse(notificationModel.id), notificationModel?.title, notificationModel?.comment, platformChannelSpecifics, payload: notificationModel.id);
  }
  void postIsTouched(NotificationModel notificationModel) async {
    try{
        if (await authController.checkInternetConnectivity()) {
          final ProgressDialog progressDialog = loadingDialog(Get.overlayContext);
          progressDialog.show();
          NotificationsProvider().postIsTouched(notificationModel).then((resp) {
            if (resp != null) {
              progressDialog.hide();
              // _user.value=resp;
              // isProcessing(false);
              // Get.toNamed(Routes.HOME);
              Helpers.showSnackbar(title:'success'.tr,message: 'your_tasks_has_been_successfully_update'.tr);
            } else {
              progressDialog.hide();
              Helpers.showSnackbar(message: 'pleas_correct_username_or_password'.tr);

            }
          });
        } else {
          Helpers.showSnackbar(message: 'error_dialog__no_internet'.tr);
        }
    }catch(e){
      Helpers.showSnackbar(message: 'pleas_correct_username_or_password'.tr);
      print(e);
    }
  }
  void postIsRead(NotificationModel notificationModel) async {
    try{
      if (await authController.checkInternetConnectivity()) {
        final ProgressDialog progressDialog = loadingDialog(Get.overlayContext);
        progressDialog.show();
        NotificationsProvider().postIsRead(notificationModel).then((resp) {
          if (resp != null) {
            progressDialog.hide();
            // _user.value=resp;
            // isProcessing(false);
            // Get.toNamed(Routes.HOME);
            Helpers.showSnackbar(title:'success'.tr,message: 'your_tasks_has_been_successfully_update'.tr);
          } else {
            progressDialog.hide();
            Helpers.showSnackbar(message: 'pleas_correct_username_or_password'.tr);

          }
        });
      } else {
        Helpers.showSnackbar(message: 'error_dialog__no_internet'.tr);
      }
    }catch(e){
      Helpers.showSnackbar(message: 'pleas_correct_username_or_password'.tr);
      print(e);
    }
  }
}
