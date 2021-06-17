import 'package:get/get.dart';
import 'package:waiter/app/data/models/sales.dart';
import 'package:waiter/app/data/providers/order_list_provider.dart';

class OrderViewController extends GetxController {
  var isLoading = true.obs;
  final _sales = Sales().obs;
  Sales get sales=>_sales.value;
  // List<Sales> get salesList=>_salesList.value;
  final _reference=''.obs;
  final _orderStatus=''.obs;
  String get reference=>_reference.value;
  String get orderStatus=>_orderStatus.value;
  @override
  void onInit()async {
    super.onInit();
    if(Get.arguments !=null && Get.arguments.length > 0){
      _reference.value=Get.arguments['reference'];
      _orderStatus.value=Get.arguments['orderStatus'];
      await getSingleSales(reference);
      print(reference);
      print('reference====');
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  Future<void> getSingleSales(reference) async {
    try {
      isLoading(true);
      var salesValue = await OrderListProvider().getOneSales(reference,orderStatus);
      if (salesValue != null) {
        _sales.value=salesValue;
      }else{
        _sales.value=null;
      }
    } finally {
      isLoading(false);
    }
  }
}
