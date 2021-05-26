import 'package:get/get.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';

import 'modules/home/controllers/auth_controller.dart';


class GlobalBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<AppController>( AppController());
    // Get.put(AppController());

  }

}

