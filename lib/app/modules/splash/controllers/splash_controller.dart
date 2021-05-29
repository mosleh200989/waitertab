import 'package:get/get.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';
import 'package:waiter/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final AuthController authController=Get.find();
  @override
  void onInit() {
    Future.delayed(const Duration(seconds:2), () {
  authController.currentUser.username !=null? Get.offNamed(Routes.HOME):Get.offNamed(Routes.MY_USER);
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

}
