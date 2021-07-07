import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waiter/app/data/models/my_tab.dart';
import 'package:waiter/app/global_widgets/DrawerWidget.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';
import 'package:waiter/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/cancel_order.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/complete_order.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/header_title_text.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/pending_order.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/processing_order.dart';
import 'package:waiter/app/routes/app_pages.dart';

import '../controllers/order_list_controller.dart';

class OrderListView extends GetView<OrderListController> {
  @override
  Widget build(BuildContext context) {
    // final controller=Get.find<OrderListController>();
    return WillPopScope(
      onWillPop: controller.willPopCallback,
      child: Scaffold(
          drawer: DrawerWidget(),
        appBar: AppBar(
          title:Obx(()=> Text('${controller.myHandler.value.title}')),

            actions: [
              TextButton(
                onPressed: () {
                  Get.put(NotificationsController()).refreshNotificationList();
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
                  Get.offAllNamed(Routes.HOME);
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
          bottom: TabBar(
            controller: controller.tabController,
            isScrollable: true,
            labelColor: Colors.white,
            indicatorColor: Colors.red,
            automaticIndicatorColorAdjustment: true,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            indicatorWeight: 7,
            indicatorPadding: EdgeInsets.only(top: 0.0,bottom: 50),
            // labelPadding: EdgeInsets.only(bottom: 5),
            tabs:<Tab> [
              Tab(child:Text('${controller.tabs[0].title}',textAlign: TextAlign.center,style: TextStyle(fontSize: Get.theme.textTheme.caption.fontSize),),),
              Tab(child:Text('${controller.tabs[1].title}',textAlign: TextAlign.center,style: TextStyle(fontSize: Get.theme.textTheme.caption.fontSize)),),
              Tab(child:Text('${controller.tabs[2].title}',textAlign: TextAlign.center,style: TextStyle(fontSize:  Get.theme.textTheme.caption.fontSize),),),
              Tab(child:Text('${controller.tabs[3].title}',textAlign: TextAlign.center,style: TextStyle(fontSize:  Get.theme.textTheme.caption.fontSize),),),
            ],
          ),
        ),


        body: TabBarView(
          controller: controller.tabController,
          children: [
            Column(
              children: [
                  Expanded(
                    flex: 1,
                    child: HeaderTitleText(),),
                Divider(thickness: 1,indent: 1,endIndent: 2,height: 5,color: Colors.black,),
                Expanded(
                    flex:11,
                    child: PendingOrder()),
              ],
            ),
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: HeaderTitleText(),),
                Divider(thickness: 1,indent: 1,endIndent: 2,height: 5,color: Colors.black,),
                Expanded(
                    flex:11,
                    child: ProcessingOrder()),
              ],
            ),
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: HeaderTitleText(),),
                Divider(thickness: 1,indent: 1,endIndent: 2,height: 5,color: Colors.black,),
                Expanded(
                    flex:11,
                    child: CompleteOrder()),
              ],
            ),
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: HeaderTitleText(),),
                Divider(thickness: 1,indent: 1,endIndent: 2,height: 5,color: Colors.black,),
                Expanded(
                    flex:11,
                    child: CancelOrder()),
              ],
            ),
          ],
        )
      ),
    );
  }
}
