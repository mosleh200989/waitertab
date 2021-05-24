

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/modules/order_details/views/local_widgets/all_order_card_page.dart';
import 'package:waiter/app/modules/order_details/views/local_widgets/other_card_page.dart';
import 'package:waiter/app/modules/order_details/views/local_widgets/salad_page.dart';
import 'package:waiter/app/routes/app_pages.dart';

import '../controllers/order_details_controller.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailsController());
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                    height: 200,
                    child: Image(image: AssetImage('assets/images/burger_1.jpg'),  fit: BoxFit.fill,width: Get.width,)
                ),
                Positioned(
                  top: 5.0,
                    right:5.0,
                    child: InkWell(
                      onTap: () => Get.back(),
                        child: Icon(Icons.keyboard_arrow_right))),
              ],
            ),
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
                    Tab(text:'All'),
                    Tab(text:'Indian food'),
                    Tab(text:'Salad'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  AllOrderCarPage(),
                  OtherCarPage(),
                  SaladCarPage(),



                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          color: Get.theme.primaryColor,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(()=>
                   CircleAvatar(
                    radius: 10,
                    // backgroundColor: Colors.green,
                    child: Text('${controller.quantity}'),
                  ),
                ),
                Text('View Your Cart',style: TextStyle(color: Colors.white,fontSize: 18),),
                Text('Tk 0.0',style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
        ),
        onTap: () {
          Get.toNamed(Routes.CARD);
        },
      ),
    );
  }
}
