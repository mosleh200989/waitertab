

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/modules/order_details/controllers/order_details_controller.dart';

class OtherCarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderDetailsController>();
    return Center(
      child: Text('NotAvailable'.tr),
    );
  }
}