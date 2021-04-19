import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/user_db.dart';

class MyUserController extends GetxController {
  Userdb userdb =  Userdb();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

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
}
