import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waiter/app/data/models/notification.dart';
import 'package:waiter/app/global_widgets/EmptyOrdersWidget.dart';
import 'package:waiter/app/routes/app_pages.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'.tr),
        centerTitle: true,
      ),
      body:  Obx(() {
      //     if (_con.isLoading.value)
      //   return Center(child: CircularProgressIndicator());
      // else
      return controller.notificationList.isEmpty
          ? EmptyOrdersWidget()
          : RefreshIndicator(
        onRefresh: controller.refreshNotificationList,
        child: ListView.builder(
          controller: controller.scrollController,
          itemCount: controller.notificationList.length,
          // shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            NotificationModel notification = controller.notificationList[index];
            if (index == controller.notificationList.length - 1 &&
                controller.isMoreDataAvailable.value == true) {
              return Center(child: CircularProgressIndicator());
            }
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.NOTIFICATION_DETAILS);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('${notification.id ?? ''}',
                            textAlign: TextAlign.center)
                    ),
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('${notification.date ?? ''}',
                            textAlign: TextAlign.center)
                    ),
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('${notification?.from_date?? ''}',
                            textAlign: TextAlign.center)
                    ),

                    Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('${notification.comment??''}',
                            textAlign: TextAlign.center)
                    ),
                    Divider(thickness: 2,
                      indent: 2,
                      endIndent: 2,
                      color: Colors.grey,
                      height: 5,)
                  ],
                ),
              ),
            );
          },),
      );


    }
    ),
    );
  }
}
