import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/data/models/basket.dart';
import 'package:waiter/app/data/models/billerdetails.dart';
import 'package:waiter/app/data/models/payment.dart';
import 'package:waiter/app/data/models/sales.dart';
import 'package:waiter/app/data/models/table.dart';
import 'package:waiter/app/data/providers/card_provider.dart';
import 'package:waiter/app/global_widgets/helpers.dart';
import 'package:waiter/app/global_widgets/loading_dialog.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';
import 'package:waiter/app/modules/order_details/controllers/order_details_controller.dart';
import 'package:waiter/app/routes/app_pages.dart';

class CardController extends GetxController  {
final OrderDetailsController orderDetailsController=Get.find();
final AppController appController=Get.find();
final AuthController authController=Get.find();
var isLoading = true.obs;
var tableList = <TableModel>[].obs;
  final count = 1.obs;
  final _showNote=false.obs;
  bool get showNote=>_showNote.value;
  final  orderNoteController=TextEditingController();
  final  discountTextController=TextEditingController();
  final  shippingTextController=TextEditingController();
  int selectedIndex;
  String  tableId;
  bool isDineIn=false;
  bool isParcel=true;
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
final _grandTotal=0.0.obs;
double get grandTotal=>_grandTotal.value;
var isProcessing= false.obs;
var _paid_by=''.obs;
String get paid_by=>_paid_by.value;
var _cc_type=''.obs;
String get cc_type=>_cc_type.value;
var _isDineIn=0.obs;
int get getIsDineIn=>_isDineIn.value;
bool buttonActive = false;
  @override
  void onInit() async {
    super.onInit();
    await getTableList();
    for(var i=0; i<appController.basketItems.length; i++){
      _grandTotal.value = _grandTotal.value+double.parse(appController.basketItems[i].subtotal);
    }
    shippingTextController.text='0';
    discountTextController.text='0';

  }

  @override
  void onReady() {
    super.onReady();
    // discountTextController.addListener(_printLatestValue);
     update();
  }

  @override
  void onClose() {
    print('on close card controller');
    // discountTextController.dispose();
    super.onClose();
  }
@override
void onPaused() {
  print('on close card controller');
}
void discountChange(String value){
    // if(value !=null){
    //   _grandTotal.value+= int.parse(value) ;
    // }

}
void shippingChange(String text){
    /*int inputData=int.parse(text);
    print(shippingTextController.text);
    print('shippingTextController');
    if(text !=null) {
      _grandTotal.value =  grandTotal - double.parse(shippingTextController.text);
    }*/
    // if text field has a value and button is inactive
/*    if(text != null && text.length > 0 && !buttonActive){
        buttonActive = true;
        _grandTotal.value =  grandTotal - double.parse(shippingTextController.text);
        print(text);
        print('text====');
          update();
          }else if((text == null || text.length == 0) && buttonActive){
                 buttonActive = false;
                 print(text);
                 print('====text====');
                 update();
      // shippingTextController.selection = new TextSelection(
      //     baseOffset: shippingTextController.text.length,
      //     extentOffset: shippingTextController.text.length
      // );
      }*/


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
  void selectedItem(int index,)async{
    selectedIndex = index;
    tableId=tableList[index].id;
    update();
  }

void increment(int index) {
    int quantity=int.parse(appController.basketItems[index].quantity);
    quantity++;
    appController.basketItems[index].quantity=quantity.toString();
    double netPrice=double.parse(appController.basketItems[index].real_unit_price) * double.parse(appController.basketItems[index].quantity);
    appController.basketItems[index].subtotal=netPrice.toString();
    for(var i=0; i<appController.basketItems.length; i++) {
      if(index==i){
        _grandTotal.value +=
            double.parse(appController.basketItems[i].real_unit_price);
      }

    }

    update();
}
void decrement(int index){
  int quantity=int.parse(appController.basketItems[index].quantity);
  quantity--;
  appController.basketItems[index].quantity=quantity.toString();
  double netPrice=double.parse(appController.basketItems[index].real_unit_price) * double.parse(appController.basketItems[index].quantity);
  appController.basketItems[index].subtotal=netPrice.toString();
  for(var i=0; i<appController.basketItems.length; i++) {
    if(index==i){
      _grandTotal.value -=
          double.parse(appController.basketItems[i].real_unit_price);
    }

  }
  update();
}
  void removeSingleOrder(index){
    for(var i=0; i<appController.basketItems.length; i++){
      if(i==index){
        print(appController.basketItems[i].net_price);
        _grandTotal.value -= double.parse(appController.basketItems[i].subtotal);
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
      _isDineIn.value=1;
      selectedIndex=0;
      tableId=tableList[0].id;
      update();
    }
    if(isParcel==newValue){
      isDineIn=false;
      isParcel=true;
      _isDineIn.value=2;
      selectedIndex = 0;
      tableId='';
      update();
    }
  }
void changePaymentMethod(bool newValue){
  if(isCash!=newValue){
    _isReverse.value=true;
    _isCash.value=true;
    _isCC.value=false;
    _paid_by.value='cash';
  }
  if(isCC==newValue){
    _isReverse.value=true;
    _isCash.value=false;
    _isCC.value=true;
    _paid_by.value='CC';
  }
}
void changeCCMethod(bool newValue){
  if(isMada!=newValue){
    _isMada.value=true;
    _isVisa.value=false;
    _cc_type.value='mada';
  }
  if(isVisa==newValue){
    _isMada.value=false;
    _isVisa.value=true;
    _cc_type.value='visa';
  }
}
void addNotes(int index,String value){
  try {
    appController.basketItems[index].notes = value;
  } on FormatException {}
}

  void postSalesOrder() async {
    final ProgressDialog progressDialog = loadingDialog(Get.overlayContext);
    try{
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

      BillerDetails billerdetails=BillerDetails();
      billerdetails.id='3';
      billerdetails.group_name='biller';
      billerdetails.phone='0596664927';
      billerdetails.email='saleem@alama360.com';

      Basket basket;
      // TableModel tableModel=TableModel(id: tableId);
      List<Basket> items = [];
      int serial;
     if(appController.basketItems.length==0 || appController.basketItems.isEmpty){
       Helpers.showSnackbar(title:'error'.tr,message: 'please_add_item'.tr);
     }else if(isDineIn == true && tableId == null){
       Helpers.showSnackbar(title:'error'.tr,message: 'please_select_table'.tr);
     }else if( _paid_by.value== ''){
       Helpers.showSnackbar(title:'error'.tr,message: 'please_select_payment_method'.tr);
     }else if(_isCC.value==true&&_cc_type.value== ''){
       Helpers.showSnackbar(title:'error'.tr,message: 'please_select_payment_method_type'.tr);
     }else{
       if (await authController.checkInternetConnectivity()) {
         progressDialog.show();
         for(var i=0; i<appController.basketItems.length;i++){
           print(appController.basketItems.length);
           print('appController.basketItems.length');
           serial=1+i;
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
             subtotal:appController.basketItems[i].subtotal,
             product_comment:appController.basketItems[i].notes??"",
             serial:serial.toString(),
           );
           items.add(basket);
         }
         List<Payment> paymentList = [];

         for(var i=0; i<5;i++){
           Payment paymentObj=Payment();
           if(i==0){
             paymentObj.amount=grandTotal.toString();
             paymentObj.balance_amount='0';
             paymentObj.paid_by=paid_by;
             paymentObj.cc_no='';
             paymentObj.paying_gift_card_no='';
             paymentObj.cc_holder='';
             paymentObj.cheque_no='';
             paymentObj.cc_month='';
             paymentObj.cc_year='';
             paymentObj.cc_type=cc_type;
             paymentObj.cc_cvv2='';
             paymentObj.payment_note='';
           }else{
             paymentObj.amount='';
             paymentObj.balance_amount='';
             paymentObj.paid_by='';
             paymentObj.cc_no='';
             paymentObj.paying_gift_card_no='';
             paymentObj.cc_holder='';
             paymentObj.cheque_no='';
             paymentObj.cc_month='';
             paymentObj.cc_year='';
             paymentObj.cc_type='';
             paymentObj.cc_cvv2='';
             paymentObj.payment_note='';
           }
           paymentList.add(paymentObj);
         }

         sales.payment=paymentList;
         sales.billerdetails=billerdetails;
         sales.apiKey=MrConfig.mr_api_key;
         sales.customer=customer;
         sales.warehouse=warehouse;
         sales.biller=biller;
         sales.biller_id=biller;
         sales.note=pos_note;
         sales.staff_note=orderNoteController.text??'';
         sales.order_tax='';
         sales.discount=discountTextController.text??"";
         sales.shipping=shippingTextController.text??"";
         sales.total_items=appController.basketItems.length.toString();
         sales.user_id='1';
         sales.is_dine_in=getIsDineIn.toString()??'';
         sales.table_no=isDineIn==true?tableId:'';
         // isParcel==true?'':
         sales.paidby=paid_by;
         // sales.payment.cc_type=cc_type;
         sales.items=items;
         // sales.tableModel=tableModel;
         int subTotalCal=int.parse(shippingTextController.text) - int.parse(discountTextController.text);
         double grandTotalCal=grandTotal + subTotalCal;
         sales.grand_total=grandTotal.toString();
         CardProvider().postSales(sales).then((result) {
           print(result);
           print('result===');
           if (result != null ) {
             progressDialog.hide();
             // isProcessing(false);
             removeAllListAndGoToOrderList();
             Helpers.showSnackbar(title:'success'.tr,message: 'your_order_has_been_successfully_submitted'.tr);

           } else {
             progressDialog.hide();
             Helpers.showSnackbar(title:"error".tr,message:"Failed".tr,);

           }
         }, onError: (err) {
           progressDialog.hide();
           Helpers.showSnackbar(title:"error".tr,message: err.toString(),);
         });
       }else {
        Helpers.showSnackbar(message: 'error_dialog__no_internet'.tr);
     }
     }
    }catch(e){
      progressDialog.hide();
      Helpers.showSnackbar(title:"error".tr,message:"Failed".tr,);
      print('e===============');
      print(e);
    }finally{
      progressDialog.hide();
      print('finally');
    }
  }
  void removeAllList(){
    appController.basketItems.clear();
    if(appController.basketItems.length==0){
      Get.offAllNamed(Routes.HOME);
    }

  }
void removeAllListAndGoToOrderList(){
  appController.basketItems.clear();
  if(appController.basketItems.length==0){
    Get.offAllNamed(Routes.ORDER_LIST);
  }

}

Future<void> getTableList() async {
  try {
    isLoading(true);
    var tablesData = await CardProvider().getTables();
    if (tablesData != null) {
      tableList.assignAll(tablesData);
      // categoriesList.value = categories;
    }
  } finally {
    isLoading(false);
  }
}


}
