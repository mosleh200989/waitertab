import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/my_tab.dart';
import 'package:waiter/app/data/models/pagination_filter.dart';
import 'package:waiter/app/data/models/sales.dart';
import 'package:waiter/app/data/providers/order_list_provider.dart';
import 'package:waiter/app/global_widgets/helpers.dart';

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
// For Pagination
  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = true.obs;
  final _paginationFilter = PaginationFilter().obs;
  int get limit => _paginationFilter.value.limit;
  int get offset => _paginationFilter.value.offset;
  @override
  void onInit()  async {
    tabController = TabController(vsync: this, length: tabs.length);
    myHandler.value = tabs[0];
    tabController.addListener(handleSelected);
    await getAllProcessingOrder();
    await getAllCompleteOrder();
    await getAllCancelOrder();
    ever(_paginationFilter, (_) async =>  await getAllSales());
    _changePaginationFilter(1, 20);
    paginateProductList();
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
  void _changePaginationFilter(int offset, int limit) {
    _paginationFilter.update((val) {
      val.offset = offset;
      val.limit = limit;
    });

  }
  // For Pagination
  void paginateProductList() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("reached end");
        _changePaginationFilter(offset + limit, limit);
        // page++;
        // getMoreTask(page);
      }
    });
  }
  Future<void> refreshPendingList() async {
    salesList.clear();
    _changePaginationFilter(1, 20);
    Helpers.showSnackbar(title:'success'.tr,message: 'refreshed_successfully_completed'.tr);
  }
  void handleSelected() {
      myHandler.value= tabs[tabController.index];
  }
  Future<void> getAllSales() async {
    try {
      isLoading(true);
      var salesValue = await OrderListProvider().getSales(_paginationFilter.value);
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
