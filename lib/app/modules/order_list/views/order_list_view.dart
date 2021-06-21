import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waiter/app/data/models/my_tab.dart';
import 'package:waiter/app/global_widgets/DrawerWidget.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/cancel_order.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/complete_order.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/header_title_text.dart';
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
          /*IconButton(
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
          ),*/
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
    );
  }
}
