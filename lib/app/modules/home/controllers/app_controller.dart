import 'package:get/get.dart';
import 'package:waiter/app/data/models/basket.dart';

class AppController extends GetxController {
  // RxList<CartItemModel> cartItems = RxList<CartItemModel>([]);

// List<Basket> get basketItems => _basketItems.value;
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