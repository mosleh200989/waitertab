import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';
import 'package:waiter/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:waiter/app/modules/tasks/views/Local_widgets/complete_tasks.dart';
import 'package:waiter/app/modules/tasks/views/Local_widgets/list_header.dart';
import 'package:waiter/app/modules/tasks/views/Local_widgets/pending_tasks.dart';
import 'package:waiter/app/routes/app_pages.dart';

import '../controllers/tasks_controller.dart';

class TasksView extends GetView<TasksController>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'.tr),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Get.find<NotificationsController>().refreshNotificationList();
              Get.toNamed(Routes.NOTIFICATIONS);
              // Get.offNamed(Routes.NOTIFICATION_PAGE, arguments: 0);
            },
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Icon(
                  Icons.notification_important_rounded,
                  color: Colors.white,
                  size: 24,
                ),
                Obx(() {
               return Container(
                  child:  Text('${Get.find<AuthController>().inReadCount}',
                    textAlign: TextAlign.center,
                    style: Get.theme.textTheme.caption.merge   (
                      TextStyle(color: Colors.black, fontSize: 12,fontWeight: FontWeight.normal),
                    ),
                  ),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(color: Colors.blueGrey.shade200, borderRadius: BorderRadius.all(Radius.circular(10))),
                  constraints: BoxConstraints(minWidth: 15, maxWidth: 80, minHeight: 15, maxHeight: 50),
                );
}),
              ],
            ),
            // color: Colors.transparent,
          ),
          TextButton(
            onPressed: () {
              Get.offNamed(Routes.HOME);
              // Get.offNamed(Routes.NOTIFICATION_PAGE, arguments: 0);
            },
            child:Icon(
              Icons.home,
              color: Colors.white,
              size: 24,
            ),

            // color: Colors.transparent,
          ),
        ],
      ),
      body: Column(
        children:<Widget> [
          SizedBox(
            height: 55,
            child: Card(
              elevation: 5,
              child: Container(
                height: 50,
                color: Colors.white,
                width: Get.width,
                child: TabBar(
                  controller: controller.tabController,
                  // isScrollable: true,
                  labelColor: Colors.black,
                  indicatorColor: Colors.red,
                  automaticIndicatorColorAdjustment: true,
                  labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  // indicatorWeight: 10,
                  tabs:<Tab> [
                    Tab(child:Text('Pending'.tr,textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),),
                    Tab(child:Text('Complete'.tr,textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                Column(
                  children: [
                    ListHeader(),
                    Divider(thickness: 1,indent: 1,endIndent: 2,height: 5,color: Colors.black,),
                    Expanded(child: PendingTasks()),
                  ],
                ),
                Column(
                  children: [
                    ListHeader(),
                    Divider(thickness: 1,indent: 1,endIndent: 2,height: 5,color: Colors.black,),
                    Expanded(child: CompleteTasks()),
                  ],
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
