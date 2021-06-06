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
  var isLoadingProcessing = true.obs;
  var isLoadingComplete = true.obs;
  var isLoadingCancel = true.obs;
  var salesList = <Sales>[].obs;
  var salesListProcessing = <Sales>[].obs;
  var salesListComplete = <Sales>[].obs;
  var salesListCancel = <Sales>[].obs;

  @override
  void onInit()  async {
    tabController = TabController(vsync: this, length: tabs.length);
    myHandler.value = tabs[0];
    tabController.addListener(handleSelected);
    await getAllSales();
    await getAllProcessingOrder();
    await getAllCompleteOrder();
    await getAllCancelOrder();
    super.onInit();
  }

  @override
  void onReady() {
    print('on init order list controller===');
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
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
  Future<void> getAllProcessingOrder() async {
    try {
      isLoadingProcessing(true);
      var salesValue = await OrderListProvider().getProcessingSales();
      if (salesValue != null) {
        salesListProcessing.assignAll(salesValue);
        // salesList.value = salesValue;
      }else{
        salesListProcessing.value=[];
      }
    } finally {
      isLoadingProcessing(false);
    }
  }
  Future<void> getAllCompleteOrder() async {
    try {
      isLoadingComplete(true);
      var salesValue = await OrderListProvider().getCompleteSales();
      if (salesValue != null) {
        salesListComplete.assignAll(salesValue);
        // salesList.value = salesValue;
      }else{
        salesListComplete.value=[];
      }
    } finally {
      isLoadingComplete(false);
    }
  }
  Future<void> getAllCancelOrder() async {
    try {
      isLoadingCancel(true);
      var salesValue = await OrderListProvider().getCancelSales();
      if (salesValue != null) {
        salesListCancel.assignAll(salesValue);
        // salesList.value = salesValue;
      }
    } finally {
      isLoadingCancel(false);
    }
  }

}
