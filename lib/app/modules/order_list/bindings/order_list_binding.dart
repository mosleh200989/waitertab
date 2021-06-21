import 'package:get/get.dart';

import 'package:waiter/app/modules/order_list/controllers/order_view_controller.dart';

import '../controllers/order_list_controller.dart';

class OrderListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderViewController>(
      () => OrderViewController(),
    );
    Get.lazyPut<OrderListController>(()=> OrderListController());
    // Get.put(OrderListController(), permanent: true);
  }
}
