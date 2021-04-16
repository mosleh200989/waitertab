import 'package:get/get.dart';

class CardController extends GetxController {
  //TODO: Implement CardController

  final count = 1.obs;
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
  void decrement(){
    if(count.value>1){
      count.value--;
    }
  }
}
