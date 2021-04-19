import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/my_tab.dart';

class OrderListController extends GetxController  with SingleGetTickerProviderMixin {
  TabController tabController;
  final List<MyTabModel> tabs = [
     MyTabModel(title: "Pending Order", color: Colors.teal[200]),
     MyTabModel(title: "Processing Order",color: Colors.orange[200]),
     MyTabModel(title: "Complete Order",color: Colors.blueGrey[200]),
     MyTabModel(title: "Cancel Order",color: Colors.transparent),
  ];
  final myHandler=MyTabModel().obs;

  final count = 0.obs;
  @override
  void onInit() {
    tabController = TabController(vsync: this, length: tabs.length);
    myHandler.value = tabs[0];
    tabController.addListener(handleSelected);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void handleSelected() {
      myHandler.value= tabs[tabController.index];
  }
}
