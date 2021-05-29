import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/data/models/basket.dart';
import 'package:waiter/app/data/models/billerdetails.dart';
import 'package:waiter/app/data/models/payment.dart';
import 'package:waiter/app/data/models/sales.dart';
import 'package:waiter/app/data/providers/card_provider.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';
import 'package:waiter/app/modules/order_details/controllers/order_details_controller.dart';
import 'package:waiter/app/routes/app_pages.dart';

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

  void postSalesOrder() async {


    try{
      isProcessing(true);
      Sales sales=Sales();
      double total = 0.0;
      double totalBalance = 0.0;
      int total_items = 0;
      String customer = "1";
      String warehouse = "1";
      String add_item = "";
      String biller = "3";
      String pos_note = "";
      String staff_note = "معجون سنسوداين 75 مل واقي";
      // String order_tax = txtOrderTaxId;
      // String discount = txtDiscountAmnt;
      // String shipping = txtExtraChargeAmount;
      sales.apiKey=MrConfig.mr_api_key;
      sales.customer=customer;
      sales.warehouse_id=warehouse;
      sales.biller=biller;
      sales.note=pos_note;
      sales.staff_note=orderNoteController.text;
      sales.order_tax='';
      sales.discount=discountTextController.text;
      sales.shipping=shippingTextController.text;
      sales.total_items=appController.basketItems.length.toString();
      sales.user_id='1';

      BillerDetails billerdetails=BillerDetails();
      billerdetails.id='3';
      billerdetails.group_name='biller';
      billerdetails.phone='0596664927';
      billerdetails.email='saleem@alama360.com';
      sales.billerdetails=billerdetails;
      Basket basket;
      List<Basket> items = [];
      for(var i=0; i<appController.basketItems.length;i++){
        print(appController.basketItems.length);
        print('appController.basketItems.length');
        basket=Basket(
          product_id:appController.basketItems[i].product_id,
          product_name:appController.basketItems[i].product_name,
          quantity:appController.basketItems[i].quantity,
          product_base_quantity:appController.basketItems[i].quantity,
          product_code:appController.basketItems[i].product_code,
          product_unit:appController.basketItems[i].product_unit,
          product_type: "standard",
          product_option:appController.basketItems[i].product_option,
          product_discount:appController.basketItems[i].product_discount,
          product_tax:appController.basketItems[i].product_tax,
          net_price:appController.basketItems[i].net_price,
          unit_price:appController.basketItems[i].unit_price,
          real_unit_price:appController.basketItems[i].real_unit_price,
          product_comment:'',
          serial:i.toString(),
        );
        // print(basket.toMap());
        // print('===basket====');
        items.add(basket);
      }
      sales.items=items;
      Payment payment=Payment();
      payment.balance_amount='';
      payment.paid_by='';
      payment.cc_no='';
      payment.paying_gift_card_no='';
      payment.cc_holder='';
      payment.cheque_no='';
      payment.cc_month='';
      payment.cc_year='';
      payment.cc_type='';
      payment.cc_cvv2='';
      payment.payment_note='';
      sales.payment=payment;
      CardProvider().postSales(sales).then((result) {
        if (result != null) {
          isProcessing(false);
          Get.toNamed(Routes.HOME);
        } else {
          Get.snackbar("Login", "Login Failed");
        }
      });
    }catch(e){
      Get.snackbar("Login", "Failed to Login");
      print(e);
    }
  }


}
