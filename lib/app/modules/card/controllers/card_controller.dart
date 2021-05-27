import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/basket.dart';
import 'package:waiter/app/data/providers/card_provider.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';
import 'package:waiter/app/modules/order_details/controllers/order_details_controller.dart';

class CardController extends GetxController  {
final OrderDetailsController orderDetailsController=Get.find();
final AppController appController=Get.find();
  final count = 1.obs;
  final _showNote=false.obs;
  bool get showNote=>_showNote.value;
  final TextEditingController orderNoteController=TextEditingController();
  final  discountTextController=TextEditingController();
  final  shippingTextController=TextEditingController();
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
final _grandTotal=0.0.obs;
double get grandTotal=>_grandTotal.value;
var isProcessing= false.obs;
  @override
  void onInit() {
    super.onInit();
    for(var i=0; i<appController.basketItems.length; i++){
      _grandTotal.value+=double.parse(appController.basketItems[i].net_price);
    }
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

  void changeShowNoteField(bool value,int index){

    if( appController.basketItems[index].isNotes==false){
      appController.basketItems[index].isNotes=value;
      update();
    }else{
      appController.basketItems[index].isNotes=false;
      update();
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
    for(var i=0; i<appController.basketItems.length; i++) {
      _grandTotal.value +=
          double.parse(appController.basketItems[i].real_unit_price);
    }

    update();
}
void decrement(int i){
  int quantity=int.parse(appController.basketItems[i].quantity);
  quantity--;
  appController.basketItems[i].quantity=quantity.toString();
  double netPrice=double.parse(appController.basketItems[i].real_unit_price) * double.parse(appController.basketItems[i].quantity);
  appController.basketItems[i].net_price=netPrice.toString();
  for(var i=0; i<appController.basketItems.length; i++) {
    _grandTotal.value -=
        double.parse(appController.basketItems[i].real_unit_price);
  }
  update();
}
  void removeSingleOrder(index){
    for(var i=0; i<appController.basketItems.length; i++){
      if(i==index){
        print(appController.basketItems[i].net_price);
        _grandTotal.value -= double.parse(appController.basketItems[i].net_price);
        appController.basketItems.removeAt(index);
        orderDetailsController.productList.refresh();
        appController.basketItems.refresh();

      }


    }
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
void postPlaceOrder(){
try{
  Basket basket=Basket();
  isProcessing(true);
  CardProvider().postOrder(basket).then((resp){
    if(resp=="success"){
      print(resp);
      Get.snackbar("Add Order","Add Order",);
    }else{
      Get.snackbar("Add Order","Failed to add order",);
    }
  });
}catch(exception){
  isProcessing(false);
}
}

// Save Data
 /* void saveTask(Map data) {
    try {
      isProcessing(true);
      TaskProvider().saveTask(data).then((resp) {
        if (resp == "success") {
          clearTextEditingControllers();
          isProcessing(false);

          showSnackBar("Add Task", "Task Added", Colors.green);
          lstTask.clear();
          refreshList();
        } else {
          showSnackBar("Add Task", "Failed to Add Task", Colors.red);
        }
      }, onError: (err) {
        isProcessing(false);
        showSnackBar("Error", err.toString(), Colors.red);
      });
    } catch (exception) {
      isProcessing(false);
      showSnackBar("Exception", exception.toString(), Colors.red);
    }
  }*/

  void insertCity() {
    const body = {'nome': 'joao', 'idade': 47};

    CardProvider().postCity(body).then((result) {
      print(result.body);
      print(result.body);
    });
  }


}
