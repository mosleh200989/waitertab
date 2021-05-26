import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';
import 'package:waiter/app/modules/order_details/controllers/order_details_controller.dart';

class CardController extends GetxController  {
final OrderDetailsController orderDetailsController=Get.find();
final AppController appController=Get.find();
  final count = 1.obs;
  final _showNote=false.obs;
  bool get showNote=>_showNote.value;
  final TextEditingController noteController=TextEditingController();
  final TextEditingController orderNoteController=TextEditingController();
  int selectedIndex;
  bool isDineIn=false;
  bool isParcel=false;
  final _isCash=false.obs;
  final _isCC=false.obs;
  bool get isCash =>_isCash.value;
  bool get isCC =>_isCC.value;
  final _isMada=false.obs;
  final _isVisa=false.obs;
  bool get isMada =>_isMada.value;
  bool get isVisa =>_isVisa.value;
  final _isReverse=false.obs;
  bool get isReverse => _isReverse.value;
List<TextEditingController> textEditNoteList = [];
  @override
  void onInit() {
    super.onInit();
    // textEditNoteList.add(TextEditingController());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    print('on close card controller');
  }
@override
void onPaused() {
  print('on close card controller');
}

  void changeShowNoteField(bool value){
    if( showNote==false){
      _showNote.value=value;
    }else{
    _showNote.value=false;
    }
  }
  void selectedItem(int index){
    selectedIndex = index;
    update();
  }

void increment(int i) {
    int quantity=int.parse(appController.basketItems[i].quantity);
    quantity++;
    appController.basketItems[i].quantity=quantity.toString();
    double netPrice=double.parse(appController.basketItems[i].real_unit_price) * double.parse(appController.basketItems[i].quantity);
    appController.basketItems[i].net_price=netPrice.toString();
  update();
}
void decrement(int i){
  int quantity=int.parse(appController.basketItems[i].quantity);
  quantity--;
  appController.basketItems[i].quantity=quantity.toString();
  double netPrice=double.parse(appController.basketItems[i].real_unit_price) * double.parse(appController.basketItems[i].quantity);
  appController.basketItems[i].net_price=netPrice.toString();
  update();
}
  void removeSingleOrder(index){
    appController.basketItems.removeAt(index);
    orderDetailsController.productList.refresh();
/*    for(var i=0; i<orderDetailsController.productList.length; i++){
      if(orderDetailsController.productList[i].id==appController.basketItems[index].product_id){
        orderDetailsController.productList[i].isOrder= false;
        appController.basketItems.removeAt(index);
        orderDetailsController.productList.refresh();
        appController.basketItems.refresh();
      }else{
        print('Not Removed');
      }
    }*/

  }
  void changeOrderMethod(bool newValue){
    if(isDineIn!=newValue){
      isDineIn=true;
      isParcel=false;
      update();
    }
    if(isParcel==newValue){
      isDineIn=false;
      isParcel=true;
      update();
    }
    print(isDineIn);
    print(isParcel);
  }
void changePaymentMethod(bool newValue){
  if(isCash!=newValue){
    _isReverse.value=true;
    _isCash.value=true;
    _isCC.value=false;
  }
  if(isCC==newValue){
    _isReverse.value=true;
    _isCash.value=false;
    _isCC.value=true;
  }
  print(isCash);
  print(isCC);
}
void changeCCMethod(bool newValue){
  if(isMada!=newValue){
    _isMada.value=true;
    _isVisa.value=false;
  }
  if(isVisa==newValue){
    _isMada.value=false;
    _isVisa.value=true;
  }
}
void addNotes(int index,String value){
  // appController.basketItems[index].textEditContNotes.text=value;
    print( appController.basketItems[index].textEditContNotes.text??'');
    // appController.basketItems.elementAt(index).notes=textEditNoteList[index].text;
    // print(appController.basketItems[index].notes);
}
}
