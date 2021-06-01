import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/my_tab.dart';
import 'package:waiter/app/data/models/sales.dart';
import 'package:waiter/app/data/providers/order_list_provider.dart';

class OrderListController extends GetxController  with SingleGetTickerProviderMixin {
  TabController tabController;
  final List<MyTabModel> tabs = [
     MyTabModel(title: "Pending Order", color: Colors.teal[200]),
     MyTabModel(title: "Processing Order",color: Colors.orange[200]),
     MyTabModel(title: "Complete Order",color: Colors.blueGrey[200]),
     MyTabModel(title: "Cancel Order",color: Colors.transparent),
  ];
  final myHandler=MyTabModel().obs;
  var isLoading = true.obs;
  var salesList = <Sales>[].obs;
  final _sales = Sales().obs;
  Sales get sales=>_sales.value;
  // List<Sales> get salesList=>_salesList.value;
  final _reference=''.obs;
  String get reference=>_reference.value;
  @override
  void onInit()  async {
    tabController = TabController(vsync: this, length: tabs.length);
    myHandler.value = tabs[0];
    tabController.addListener(handleSelected);
    await getAllSales();
    if(Get.arguments !=null && Get.arguments.length > 0){
      _reference.value=Get.arguments['reference'];
      print(reference);
      print('reference====');
      await getSingleSales(reference);
    }

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
  Future<void> getSingleSales(reference) async {
    try {
      isLoading(true);
      var salesValue = await OrderListProvider().getOneSales(reference);
      if (salesValue != null) {
        _sales.value=salesValue;
      }
    } finally {
      isLoading(false);
    }
  }
}
