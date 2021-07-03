import 'package:get/get.dart';
import 'package:waiter/app/data/models/notification.dart';
import 'package:waiter/app/data/providers/notifications_provider.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';

class NotificationDetailsController extends GetxController {
final appController=Get.find<AppController>();
  String id;
  var isLoading = true.obs;
  final _notification = NotificationModel().obs;
  NotificationModel get notification=>_notification.value;
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
        print(notification.isread);
        print('notification.isread==============');
        // appController.postIsTouched(notification);
      }else{
        _notification.value=null;
      }
    } finally {
      isLoading(false);
    }
  }
}
