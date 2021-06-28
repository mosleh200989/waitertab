import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_constants.dart';
import 'package:waiter/app/data/models/pagination_filter.dart';
import 'package:waiter/app/data/providers/notifications_provider.dart';
import 'package:waiter/app/global_widgets/helpers.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';

class NotificationsController extends GetxController {
final authController=Get.find<AuthController>();
ScrollController scrollController = ScrollController();
var isMoreDataAvailable = true.obs;
var isDataProcessing = false.obs;
final _paginationFilter = PaginationFilter().obs;
int get li mit => _paginationFilter.value.limit;
int get offset => _paginationFilter.value.offset;
  @override
  void onInit() async{
    super.onInit();
    _changePaginationFilter(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    await getAllNotifications(_paginationFilter.value);
    paginateNotificationList();
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
  // salesList.clear();
  _changePaginationFilter(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
  await getAllNotifications(_paginationFilter.value);
  Helpers.showSnackbar(title:'success'.tr,message: 'refreshed_successfully_completed'.tr);
}
  Future<void> getAllNotifications(PaginationFilter filter) async {
    try {
      if(await authController.checkInternetConnectivity()) {
        isMoreDataAvailable(false);
        isDataProcessing(true);
        // isLoading(true);
        var salesValue = await NotificationsProvider().getNotifications(filter);
        if (salesValue != null) {
          // salesList.assignAll(salesValue);
          isDataProcessing(false);
          // salesList.addAll(salesValue);
        }else{
          // salesList.addAll([]);
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
    // salesList.addAll(salesValue);
  }catch (exception) {
    isDataProcessing(false);
  }finally{
    isDataProcessing(false);
  }
}
}
