import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/core/values/mr_constants.dart';
import 'package:waiter/app/data/models/notification.dart';
import 'package:waiter/app/data/models/pagination_filter.dart';
import 'package:waiter/app/data/providers/notifications_provider.dart';
import 'package:waiter/app/global_widgets/helpers.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';

class NotificationsController extends GetxController {
final authController=Get.find<AuthController>();
final appController=Get.find<AppController>();
ScrollController scrollController = ScrollController();
// final notificationList=<NotificationModel>[].obs;
var notificationList = <NotificationModel>[].obs;
// List<NotificationModel> get notificationList=>_notificationList.value;
var isMoreDataAvailable = true.obs;
var isDataProcessing = false.obs;
final _paginationFilter = PaginationFilter().obs;
int get limit => _paginationFilter.value.limit;
int get offset => _paginationFilter.value.offset;

  @override
  void onInit() async{
    super.onInit();
    _changePaginationFilter(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    if(authController.currentUser.id != null){
      await getAllNotifications(_paginationFilter.value);
    }
    paginateNotificationList();
    print('on init notification controller');
    // for(var i=0; i<notificationList.length; i++){
    //   if(notificationList[i].notificationsAlert.is_read !='1'){
    //     authController.isReadCountSet.value++;
    //     print(authController.inReadCount);
    //     print('inReadCount');
    //   }
    // }
  /*  Timer.periodic(Duration(seconds: 10), (timer) async {
      await getAllNotifications(_paginationFilter.value);
    });*/

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
void paginateNotificationList() {
  scrollController.addListener(() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent)  {
      print("reached end");
      _changePaginationFilter(offset + limit, limit);
      await getMoreNotifications(_paginationFilter.value);
    }
  });
}
Future<void> refreshNotificationList() async {
  notificationList.clear();
  _changePaginationFilter(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
  if(authController.currentUser.id != null){
    await getAllNotifications(_paginationFilter.value);
  }


  Helpers.showSnackbar(title:'success'.tr,message: 'refreshed_successfully_completed'.tr);
}
  Future<void> getAllNotifications(PaginationFilter filter) async {
    try {
      if(await authController.checkInternetConnectivity()) {
        isMoreDataAvailable(false);
        isDataProcessing(true);
        // isLoading(true);
        var notificationValue = await NotificationsProvider().getNotifications(filter);
        if (notificationValue != null) {
          // salesList.assignAll(salesValue);
          isDataProcessing(false);
          notificationList.addAll(notificationValue);
          authController.isReadCountSet.value=0;
          for(var i=0; i<notificationList.length; i++){
            if(notificationList[i].notificationsAlert.is_read !='1'){
              authController.isReadCountSet.value++;
              print(authController.inReadCount);
              print('inReadCount');
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
      isDataProcessing(false);
    }
  }
Future<void> getMoreNotifications(PaginationFilter filter)async{
  print('get more sales');
  try{
    var notificationValue = await NotificationsProvider().getNotifications(filter);
    if (notificationValue.length > 0) {
      isMoreDataAvailable(true);
    } else {
      isMoreDataAvailable(false);
    }
    notificationList.addAll(notificationValue);
  }catch (exception) {
    isDataProcessing(false);
  }finally{
    isDataProcessing(false);
  }
}
void isReadNotification(String id)async{
  NotificationModel notificationObj=NotificationModel();
  notificationObj.user_id=authController.currentUser.id;
  notificationObj.id=id;
  notificationObj.is_touch='1';
  notificationObj.apiKey=MrConfig.mr_api_key;
  postIsReadNotification(notificationObj);

}
  void postIsReadNotification(NotificationModel notificationModel) async {
    try{
      if (await authController.checkInternetConnectivity()) {
        NotificationsProvider().postIsRead(notificationModel).then((resp) async{
          if (resp ==true) {
            print(resp);
            print('resp===========');
            // await getAllNotifications(_paginationFilter.value);
            refreshNotificationList();
            // Helpers.showSnackbar(title:'success'.tr,message: 'your_tasks_has_been_successfully_update'.tr);
          } else {
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
