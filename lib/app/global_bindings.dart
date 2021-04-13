import 'package:get/get.dart';

import 'modules/home/controllers/auth_controller.dart';


class GlobalBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);


  }

}

