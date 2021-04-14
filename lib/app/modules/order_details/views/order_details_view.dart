import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/order_details_controller.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailsController());

    return Scaffold(
      backgroundColor: Bacc,

      body: Column(
        children: [
          SizedBox(height: 200,),
          Container(
            height: 50,
            color: Colors.blueGrey,
            width: Get.width,
            child: TabBar(
              controller: controller.tabController,
              tabs: [
                Tab(text:'All'),
                Tab(text:'Indian food'),
                Tab(text:'Salad'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                CarPage(),
                BikePage(),
                CarPage(),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailsController());
    return Center(
      child: Obx(() => Text(controller.car.value)),
    );
  }
}



class BikePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailsController());
    return Center(
      child: Obx(() => Text(controller.bike.value)),
    );
  }
}
