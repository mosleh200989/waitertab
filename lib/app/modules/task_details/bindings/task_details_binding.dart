import 'package:get/get.dart';

import '../controllers/tasks_details_controller.dart';

class TaskDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TasksDetailsController>(
      () => TasksDetailsController(),
    );
  }
}
