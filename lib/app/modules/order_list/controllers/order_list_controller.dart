import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/my_tab.dart';
import 'package:waiter/app/data/models/sales.dart';
import 'package:waiter/app/data/providers/order_list_provider.dart';

class OrderListController extends GetxController  with SingleGetTickerProviderMixin {
  TabController tabController;
  final List<MyTabModel> tabs = [
     MyTabModel(title: "PendingOrder".tr, color: Colors.teal[200]),
     MyTabModel(title: "ProcessingOrder".tr,color: Colors.orange[200]),
     MyTabModel(title: "CompleteOrder".tr,color: Colors.blueGrey[200]),
     MyTabModel(title: "CancelOrder".tr,color: Colors.transparent),
  ];
  final myHandler=MyTabModel().obs;
  var isLoading = true.obs;
  var salesList = <Sales>[].obs;

  @override
  void onInit()  async {
    tabController = TabController(vsync: this, length: tabs.length);
    myHandler.value = tabs[0];
    tabController.addListener(handleSelected);
    await getAllSales();


    super.onInit();
  }

  @override
  void onReady() {
    print('on init order list controller===');
    super.onReady();
  }

  @override
  void onClose() {}
  void handleSelected() {
      myHandler.value= tabs[tabController.index];
  }
  Future<void> getAllSales() async {
    try {
      isLoading(true);
      var salesValue = await OrderListProvider().getSales();
      if (salesValue != null) {
        salesList.assignAll(salesValue);
        // salesList.value = salesValue;
      }
    } finally {
      isLoading(false);
    }
  }

}
