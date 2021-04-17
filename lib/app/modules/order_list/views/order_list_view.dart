import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waiter/app/modules/order_details/views/local_widgets/all_order_card_page.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/cancel_order.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/complete_order.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/pending_order.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/processing_order.dart';

import '../controllers/order_list_controller.dart';

class OrderListView extends GetView<OrderListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: controller.tabController.index==0? Text('OrderListView'):null,
        centerTitle: true,
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
                tabs: [
                  Tab(child:Text('Pending Order',textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),),
                  Tab(child:Text('Processing Order',textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),),
                  Tab(child:Text('Complete Order',textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),),
                  Tab(child:Text('Cancel Order',textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),),
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
