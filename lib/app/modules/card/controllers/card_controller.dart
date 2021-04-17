import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CardController extends GetxController {


  final count = 1.obs;
  final showNote=false.obs;
  final TextEditingController noteController=TextEditingController();
  final TextEditingController orderNoteController=TextEditingController();
  int selectedIndex;
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
  void changeShowNoteField(bool value){
    if( showNote.value==false){
      showNote.value=value;
    }else{
    showNote.value=false;
    }
  }
  void selectedItem(int index){
    selectedIndex = index;
    update();
  }
}
