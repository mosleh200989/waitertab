import 'package:get/get.dart';
import 'package:waiter/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () {
    Get.toNamed(Routes.MY_USER);
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
