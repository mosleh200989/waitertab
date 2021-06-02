import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waiter/app/global_widgets/DrawerWidget.dart';
import 'package:waiter/app/modules/order_details/views/local_widgets/all_order_card_page.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/cancel_order.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/complete_order.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/pending_order.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/processing_order.dart';

import '../controllers/order_list_controller.dart';

class OrderListView extends GetView<OrderListController> {
  @override
  Widget build(BuildContext context) {
    // final controller=Get.find<OrderListController>();
    return Scaffold(
        drawer: DrawerWidget(),
      appBar: AppBar(
        title:Obx(()=> Text('${controller.myHandler.value.title}')),
        actions: [
          IconButton(
            icon: const Icon(Icons.rice_bowl),
            color: Colors.white,
            onPressed: () {
              print('android');
            },
          ),
          TextButton(
            onPressed: () {
              // Get.offNamed(Routes.NOTIFICATION_PAGE, arguments: 0);
            },
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 28,
                ),
                Container(
                  child: Text('10',
                    textAlign: TextAlign.center,
                    style: Get.theme.textTheme.caption.merge(
                      TextStyle(color: Colors.black, fontSize: 10,),
                    ),
                  ),
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(color: Colors.orange.shade200, borderRadius: BorderRadius.all(Radius.circular(10))),
                  constraints: BoxConstraints(minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
                ),
              ],
            ),
            // color: Colors.transparent,
          ),
        ],
      ),


      body: Column(
        children:<Widget> [
          Card(
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
                  Tab(child:Text('${controller.tabs[0].title}',textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),),
                  Tab(child:Text('${controller.tabs[1].title}',textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),),
                  Tab(child:Text('${controller.tabs[2].title}',textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),),
                  Tab(child:Text('${controller.tabs[3].title}',textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
              PendingOrder(),
              ProcessingOrder(),
              CompleteOrder(),
              CancelOrder(),
              ],
            ),
          ),
        ],
      )
    );
  }
}
