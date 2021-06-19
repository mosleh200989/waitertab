import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_constants.dart';
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

  var isDataProcessing = false.obs;
// For Pagination
  ScrollController scrollController = ScrollController();
  ScrollController scrollControllerProcessing = ScrollController();
  ScrollController scrollControllerComplete = ScrollController();
  ScrollController scrollControllerCancel = ScrollController();
  var isMoreDataAvailable = true.obs;
  var isMoreDataAvailableProcessing = true.obs;
  var isMoreDataAvailableComplete = true.obs;
  var isMoreDataAvailableCancel = true.obs;

  final _paginationFilter = PaginationFilter().obs;
  final _paginationFilterProcessing = PaginationFilter().obs;
  final _paginationFilterComplete = PaginationFilter().obs;
  final _paginationFilterCancel = PaginationFilter().obs;
  int get limit => _paginationFilter.value.limit;
  int get offset => _paginationFilter.value.offset;
  int get limitProcessing => _paginationFilterProcessing.value.limit;
  int get offsetProcessing => _paginationFilterProcessing.value.offset;
  int get limitComplete => _paginationFilterComplete.value.limit;
  int get offsetComplete => _paginationFilterComplete.value.offset;
  int get limitCancel => _paginationFilterCancel.value.limit;
  int get offsetCancel => _paginationFilterCancel.value.offset;
  @override
  void onInit()  async {
    tabController = TabController(vsync: this, length: tabs.length);
    myHandler.value = tabs[0];
    tabController.addListener(handleSelected);
    _changePaginationFilter(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    _changePaginationFilterProcessing(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    _changePaginationFilterComplete(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    _changePaginationFilterCancel(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    await getAllSales(_paginationFilter.value);
    await getAllProcessingOrder(_paginationFilterProcessing.value);
    await getAllCompleteOrder(_paginationFilterComplete.value);
    await getAllCancelOrder(_paginationFilterCancel.value);

    // ever(_paginationFilter, (_) async =>  await getAllSales());
    // once(_paginationFilter, (_) async => await getAllSales());
    // debounce(_paginationFilter, (_) async => await getMoreSales(), time: Duration(seconds: 1));

    paginateProductList();
    paginateProcessingOrder();
    paginateCompleteOrder();
    paginateCancelOrder();
    // interval(_paginationFilter, (_) => print("interval $_"), time: Duration(seconds: 1));
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
  void _changePaginationFilter(int offset, int limit) {
    _paginationFilter.update((val) {
      val.offset = offset;
      val.limit = limit;
    });

  }
  void _changePaginationFilterProcessing(int offset, int limit) {
    _paginationFilterProcessing.update((val) {
      val.offset = offset;
      val.limit = limit;
    });

  }
  void _changePaginationFilterComplete(int offset, int limit) {
    _paginationFilterComplete.update((val) {
      val.offset = offset;
      val.limit = limit;
    });

  }
  void _changePaginationFilterCancel(int offset, int limit) {
    _paginationFilterCancel.update((val) {
      val.offset = offset;
      val.limit = limit;
    });

  }
  // For Pagination

  Future<void> refreshPendingList() async {
    salesList.clear();
    _changePaginationFilter(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    await getAllSales(_paginationFilter.value);
    Helpers.showSnackbar(title:'success'.tr,message: 'refreshed_successfully_completed'.tr);
  }

  Future<void> refreshProcessingList() async {
    salesListProcessing.clear();
    _changePaginationFilterProcessing(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    await getAllProcessingOrder(_paginationFilterProcessing.value);
    Helpers.showSnackbar(title:'success'.tr,message: 'refreshed_successfully_completed'.tr);
  }
  Future<void> refreshCompleteList() async {
    salesListComplete.clear();
    _changePaginationFilterComplete(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    await getAllCompleteOrder(_paginationFilterComplete.value);
    Helpers.showSnackbar(title:'success'.tr,message: 'refreshed_successfully_completed'.tr);
  }
  Future<void> refreshCancelList() async {
    salesListCancel.clear();
    _changePaginationFilterCancel(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    await getAllCancelOrder(_paginationFilterCancel.value);
    Helpers.showSnackbar(title:'success'.tr,message: 'refreshed_successfully_completed'.tr);
  }
  void paginateProductList() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent)  {
        print("reached end");
        _changePaginationFilter(offset + limit, limit);
        await getMoreSales(_paginationFilter.value);
        // page++;
        // getMoreTask(page);
      }
    });
  }
  Future<void> getAllSales(PaginationFilter filter) async {
    try {
      isMoreDataAvailable(false);
      isDataProcessing(true);
      // isLoading(true);
      var salesValue = await OrderListProvider().getSales(filter);
      if (salesValue != null) {
        // salesList.assignAll(salesValue);
        isDataProcessing(false);
        salesList.addAll(salesValue);

      }
    } finally {
      // isLoading(false);
      isDataProcessing(false);
    }
  }
  Future<void> getMoreSales(PaginationFilter filter)async{
    print('get more sales');
    try{
      var salesValue = await OrderListProvider().getSales(filter);
      if (salesValue.length > 0) {
        isMoreDataAvailable(true);
      } else {
        isMoreDataAvailable(false);
      }
      salesList.addAll(salesValue);
    }catch (exception) {
      isDataProcessing(false);
    }finally{
      isDataProcessing(false);
    }
}
  //processing order start
  void paginateProcessingOrder() {
    scrollControllerProcessing.addListener(() async {
      if (scrollControllerProcessing.position.pixels ==
          scrollControllerProcessing.position.maxScrollExtent)  {
        print("reached end");
        _changePaginationFilterProcessing(offsetProcessing + limitProcessing, limit);
        await getMoreProcessingOrder(_paginationFilterProcessing.value);
      }
    });
  }
  Future<void> getAllProcessingOrder(PaginationFilter filter) async {
    try {
      isMoreDataAvailableProcessing(false);
      isLoadingProcessing(true);
      var salesValue = await OrderListProvider().getProcessingSales(filter);
      if (salesValue != null) {
        isLoadingProcessing(false);
        salesListProcessing.assignAll(salesValue);
        // salesList.value = salesValue;
      }else{
        salesListProcessing.value=[];
      }
    } finally {
      isLoadingProcessing(false);
    }
  }

  Future<void> getMoreProcessingOrder(PaginationFilter filter)async{
    print('get more sales');
    try{
      var salesValue = await OrderListProvider().getProcessingSales(filter);
      if (salesValue.length > 0) {
        isMoreDataAvailableProcessing(true);
      } else {
        isMoreDataAvailableProcessing(false);
      }
      salesListProcessing.addAll(salesValue);
    }catch (exception) {
      isLoadingProcessing(false);
    }finally{
      isLoadingProcessing(false);
    }
  }


  //processing order end
  //complete order start
  void paginateCompleteOrder() {
    scrollControllerComplete.addListener(() async {
      if (scrollControllerComplete.position.pixels ==
          scrollControllerComplete.position.maxScrollExtent)  {
        print("reached end");
        _changePaginationFilterComplete(offsetComplete + offsetComplete, limit);
        await getMoreCompleteOrder(_paginationFilterComplete.value);
      }
    });
  }
  Future<void> getAllCompleteOrder(PaginationFilter filter) async {
    try {
      isMoreDataAvailableComplete(false);
      isLoadingComplete(true);
      var salesValue = await OrderListProvider().getCompleteSales(filter);
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
  Future<void> getMoreCompleteOrder(PaginationFilter filter)async{
    print('getMoreCompleteOrder');
    try{
      var salesValue = await OrderListProvider().getCompleteSales(filter);
      if (salesValue.length > 0) {
        isMoreDataAvailableComplete(true);
      } else {
        isMoreDataAvailableComplete(false);
      }
      salesListComplete.addAll(salesValue);
    }catch (exception) {
      isLoadingComplete(false);
    }finally{
      isLoadingComplete(false);
    }
  }
  //complete order end
  //Cancel order start
  void paginateCancelOrder() {
    scrollControllerCancel.addListener(() async {
      if (scrollControllerCancel.position.pixels ==
          scrollControllerCancel.position.maxScrollExtent)  {
        _changePaginationFilterCancel(offsetCancel + offsetCancel, limit);
        await getMoreCancelOrder(_paginationFilterCancel.value);
      }
    });
  }
  Future<void> getAllCancelOrder(PaginationFilter filter) async {
    try {
      isMoreDataAvailableCancel(false);
      isLoadingCancel(true);
      var salesValue = await OrderListProvider().getCancelSales(filter);
      if (salesValue != null) {
        salesListCancel.assignAll(salesValue);
        // salesList.value = salesValue;
      }
    } finally {
      isLoadingCancel(false);
    }
  }
  Future<void> getMoreCancelOrder(PaginationFilter filter)async{
    print('getMoreCancelOrder');
    try{
      var salesValue = await OrderListProvider().getCancelSales(filter);
      if (salesValue.length > 0) {
        isMoreDataAvailableCancel(true);
      } else {
        isMoreDataAvailableCancel(false);
      }
      salesListCancel.addAll(salesValue);
    }catch (exception) {
      isLoadingCancel(false);
    }finally{
      isLoadingCancel(false);
    }
  }

//Cancel order end

}
