import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/categories.dart';
import 'package:waiter/app/data/providers/categories_provider.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var categoriesList = <Categories>[].obs;
  final count = 0.obs;
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
  void onClose() {}
  void increment() => count.value++;
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
      isLoading(true);
      var categories = await CategoriesProvider().getCategories();
      if (categories != null) {
        categoriesList.assignAll(categories);
        // categoriesList.value = categories;
      }
    } finally {
      isLoading(false);
    }
  }
}
