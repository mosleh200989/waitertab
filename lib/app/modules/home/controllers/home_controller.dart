import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/categories.dart';
import 'package:waiter/app/data/providers/categories_provider.dart';
import 'package:waiter/app/global_widgets/helpers.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';

class HomeController extends GetxController {
  final AuthController authController=Get.find();
  var isLoading = true.obs;
  var categoriesList = <Categories>[].obs;
  @override
  void onInit()async {
    super.onInit();
   await getAllCategories();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  void updateFunction(){
    update();
  }
  TextEditingController textController = TextEditingController();
  List<String> newDataList = List.from(mainDataList);
 void onItemChanged(String value) {
           print(value);
           print('value====');
      newDataList = mainDataList.where((string) => string.toLowerCase().contains(value.toLowerCase()));

  }

  static List<String> mainDataList = [
    "Apple",
    "Apricot",
    "Banana",
    "Blackberry",
    "Coconut",
    "Date",
    "Fig",
    "Gooseberry",
    "Grapes",
    "Lemon",
    "Litchi",
    "Mango",
    "Orange",
    "Papaya",
    "Peach",
    "Pineapple",
    "Pomegranate",
    "Starfruit"
  ];
  Future<void> getAllCategories() async {
    try {
      if(await authController.checkInternetConnectivity()) {
        isLoading(true);
        var categories = await CategoriesProvider().getCategories();
        if (categories != null) {
          isLoading(false);
          categoriesList.assignAll(categories);
          // categoriesList.value = categories;
        }
      }else{
        isLoading(false);
        Helpers.showSnackbar(title:'error',message: 'error_dialog__no_internet'.tr);
      }
    } finally {
      isLoading(false);
    }
  }
}
