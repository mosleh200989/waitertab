import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/data/models/user_db.dart';
import 'package:waiter/app/data/providers/my_user_provider.dart';
import 'package:waiter/app/global_widgets/helpers.dart';
import 'package:waiter/app/global_widgets/loading_dialog.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';
import 'package:waiter/app/routes/app_pages.dart';

class MyUserController extends GetxController {
  final authController=Get.find<AuthController>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  var _user=UserDb().obs;
  UserDb get getUser=>_user.value;
  UserDb userDb = UserDb();
  var isProcessing = false.obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void handleFormSubmit() async {
    userDb.identity =nameController.text;
    userDb.password = passwordController.text;
    userDb.apiKey = MrConfig.mr_api_key;
    try{
      // isProcessing(true);
      if (nameController.text.isEmpty) {
        Helpers.showSnackbar(message: 'warning_dialog__input_name'.tr);

      }else if (passwordController.text.isEmpty) {
        Helpers.showSnackbar(message: 'warning_dialog__input_password'.tr);

      }else{
        if (await authController.checkInternetConnectivity()) {
          final ProgressDialog progressDialog = loadingDialog(Get.overlayContext);
          progressDialog.show();
          MyUserProvider().postLogin(userDb).then((resp) {
            if (resp != null) {
              progressDialog.hide();
              _user.value=resp;
              // isProcessing(false);
              Get.toNamed(Routes.HOME);
            } else {
              progressDialog.hide();
              Helpers.showSnackbar(message: 'pleas_correct_username_or_password'.tr);

            }
          });
        } else {
          Helpers.showSnackbar(message: 'error_dialog__no_internet'.tr);
        }
      }
    }catch(e){
      Helpers.showSnackbar(message: 'pleas_correct_username_or_password'.tr);
      print(e);
    }
  }

}
