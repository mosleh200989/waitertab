import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/basket.dart';
import 'package:waiter/app/data/models/product.dart';
import 'package:waiter/app/data/providers/order_details_provider.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';

class OrderDetailsController extends GetxController  with SingleGetTickerProviderMixin{
 final AppController appController=Get.find();
  var isLoading = true.obs;
  var productList = <Product>[].obs;
  Basket basket;
  final Widget dividerLabel=  Container( height: 30.0,width: 2.0, color: Colors.grey,);
  var product=Product().obs;
  var counter = <int>[].obs;
  TabController tabController;
  final count = 1.obs;
  final bike = ''.obs;
  final car = ''.obs;
  final agreedToOrder = false.obs;
  final catId=''.obs;
  final _quantity = 0.obs;
  set quantity(int value) => _quantity.value = value;
  int get quantity => _quantity.value;

 int get cartQuantity {
   return appController.basketItems.length;
 }
 final _grandTotal=0.0.obs;
 double get grandTotal=>_grandTotal.value;

  @override
  void onInit()async {
    tabController = TabController(vsync: this, length: 3);
    bike.value = 'BMC';
    car.value = 'Ferrari';
    if(Get.arguments !=null && Get.arguments.length>0){
      catId.value=Get.arguments['catId'];
      await getAllProducts();
    }
    // incrementGrandTotal();
    super.onInit();
  }

  @override
  void onReady() {
   print('or ready order controller');
    super.onReady();
  }

  @override
  void onClose() {}
  void increment(int i) {
    productList[i].counter++;
   productList[i].totalPrice=productList[i].counter * double.parse(productList[i].price);
    update();
  }

 void incrementOpenDialog(int i) {
   productList[i].totalPrice= 1 * double.parse(productList[i].price);
   update();
 }
 void decrementOpenDialog(int i) {
   productList[i].totalPrice =1 * double.parse(productList[i].price);
   update();
 }
  void decrement(int i){
    if(productList[i].counter > 1 ){
      productList[i].counter--;
      productList[i].totalPrice=productList[i].counter * double.parse(productList[i].price);
      update();
    }
  }
  void setAgreedToOrder(bool newValue, int index) {
   if(newValue==false) {
     for(var i=0; i<appController.basketItems.length;i++){
       if(appController.basketItems[i].product_id==productList[index].id){
         print(appController.basketItems[i].net_price??'0.0');
         productList[index].isOrder = newValue;
         _grandTotal.value -= double.parse(appController.basketItems[i].subtotal);
         appController.basketItems.removeAt(i);
         productList.refresh();
         appController.basketItems.refresh();


       }
     }
   }else{
     print('in condition===');
     productList[index].isOrder= newValue;
     productList.refresh();
     appController.basketItems.refresh();

   }

  }
  Future<void> getAllProducts() async {
    try {
      isLoading(true);
      var products = await OrderDetailsProvider().getProduct(catId.value);
      if (products != null) {
        productList.assignAll(products);
        // categoriesList.value = categories;
      }
    } finally {
      isLoading(false);
    }
  }
  // incrementQuantity() {
  //   if (this.quantity >= 10) {
  //     this.quantity = 10;
  //   } else {
  //     this.quantity += 1;
  //   }
  // }
  //
  // decrementQuantity() {
  //   if (this.quantity <= 1) {
  //     this.quantity = 1;
  //   } else {
  //     this.quantity -= 1;
  //   }
  // }

  Future<void> addToBasketAndBuyClickEvent(int index) async {
  try{
    Basket basket=Basket(
      product_id: productList.elementAt(index).id,
      product_name: productList.elementAt(index).name,
      net_price: productList[index].net_price,
      quantity: productList.elementAt(index).counter.toString(),
      product_base_quantity: productList.elementAt(index).counter.toString(),
      real_unit_price: productList.elementAt(index).price,
      product_code: productList.elementAt(index).code,
      product_option: productList.elementAt(index).option,
      product_tax: productList.elementAt(index).tax_rate.id,
      unit_price: productList.elementAt(index).unit_price,
      product_unit: productList.elementAt(index).unit.id,
      product_discount: '0',
      item_discount: '0.0',
      subtotal: productList[index].totalPrice.toString() ?? productList[index].price,
    );
    setAgreedToOrder(true, index);
    appController.basketItems.add(basket);
    for(var i=0; i< appController.basketItems.length; i++){
      if(i==index){
        _grandTotal.value+= double.parse(appController.basketItems[i].subtotal);
      }
      update();
    }
  /*  if(cartQuantity > 0 && cartQuantity !=0){
    for (var i=0; i<appController.basketItems.length; i++) {
      if(appController.basketItems[i].product_id==productList.elementAt(index).id){
        print(appController.basketItems[i].product_id);
        // increment(index);
        setAgreedToOrder(true, index);
        print('true');
        print(productList.elementAt(index).id);
      }else{
      Basket basket=Basket(
          product_id: productList.elementAt(index).id,
          product_name: productList.elementAt(index).name,
          net_price: productList.elementAt(index).totalPrice.toString() !=null?productList.elementAt(index).totalPrice.toString() : productList.elementAt(index).price,
          quantity: productList.elementAt(index).counter.toString(),
          real_unit_price: productList.elementAt(index).price.toString(),
        );
      setAgreedToOrder(true, index);
        appController.basketItems.add(basket);
        print("false");
      }
    }
    }else{
     Basket basket=Basket(
        product_id: productList.elementAt(index).id,
        product_name: productList.elementAt(index).name,
        net_price: productList.elementAt(index).totalPrice.toString() !=null?productList.elementAt(index).totalPrice.toString() : productList.elementAt(index).price,
        quantity: productList.elementAt(index).counter.toString(),
        real_unit_price: productList.elementAt(index).price.toString(),
      );
      appController.basketItems.add(basket);
     setAgreedToOrder(true, index);
     print(Get.isDialogOpen);
     print('is open ');
     // Get.reload(tag: 'ordDtl');
     // Get.back();
      print("false========");
      print("false========");
    }
*/
    //  basket =
    // appController.basketItems.value.firstWhere((cartItem) {
    //   print('ekhane===');
    //   print(cartItem.product_id);
    //   print(productList.elementAt(i).id);
    //   print('ekhane');
    //   return cartItem.product_id == productList.elementAt(i).id;
    // });

    // increment(i);
    // print(appController.basketItems[i].product_name);
    // print(basket.net_price);
    // print('basket===');
  }catch(error){
 print(error);
  }
  Get.back();
  // Get.reload();
  // Get.reloadAll();
  }

}


/*

class MyTabController extends GetxController with SingleGetTickerProviderMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];

  TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
To use MyTabController inside a Stateless widget:

class MyTabbedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyTabController _tabx = Get.put(MyTabController());
    // ↑ init tab controller

    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabx.controller,
          tabs: _tabx.myTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabx.controller,
        children: _tabx.myTabs.map((Tab tab) {
          final String label = tab.text.toLowerCase();
          return Center(
            child: Text(
              'This is the $label tab',
              style: const TextStyle(fontSize: 36),
            ),
          );
        }).toList(),
      ),
    );
  }
}

Here's the rest of the app example to just copy & paste into Android Studio / VisualStudio Code to run:

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Tab Example'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text('Some random stuff'),
            ),
          ),
          Expanded(
            flex: 4,
            child: MyTabbedWidget(),
          )
        ],
      ),
    );
  }
}

class MyTabController extends GetxController with SingleGetTickerProviderMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];

  TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

class MyTabbedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyTabController _tabx = Get.put(MyTabController());
    // ↑ init tab controller

    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabx.controller,
          tabs: _tabx.myTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabx.controller,
        children: _tabx.myTabs.map((Tab tab) {
          final String label = tab.text.toLowerCase();
          return Center(
            child: Text(
              'This is the $label tab',
              style: const TextStyle(fontSize: 36),
            ),
          );
        }).toList(),
      ),
    );
  }
}*/
