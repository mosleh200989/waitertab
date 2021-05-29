import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/data/models/user_db.dart';
import 'package:waiter/app/data/providers/my_user_provider.dart';
import 'package:waiter/app/routes/app_pages.dart';

class MyUserController extends GetxController {
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
      isProcessing(true);
      MyUserProvider().postLogin(userDb).then((resp) {
        if (resp != null) {
          _user.value=resp;
          isProcessing(false);
          Get.toNamed(Routes.HOME);
        } else {
          Get.snackbar("Login", "Login Failed");
        }
      });
    }catch(e){
      Get.snackbar("Login", "Failed to Login");
      print(e);
    }
  }

}
