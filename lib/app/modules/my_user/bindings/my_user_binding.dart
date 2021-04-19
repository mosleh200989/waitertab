import 'package:get/get.dart';

import '../controllers/my_user_controller.dart';

class MyUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyUserController>(
      () => MyUserController(),
    );
  }
}
