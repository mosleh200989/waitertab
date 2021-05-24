import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/basket.dart';
import 'package:waiter/app/data/models/product.dart';
import 'package:waiter/app/data/providers/order_details_provider.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';

class OrderDetailsController extends GetxController  with SingleGetTickerProviderMixin{
  final basketItems=<Basket>[].obs;
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
  @override
  void onInit()async {
    tabController = TabController(vsync: this, length: 3);
    bike.value = 'BMC';
    car.value = 'Ferrari';
    if(Get.arguments !=null && Get.arguments.length>0){
      catId.value=Get.arguments['catId'];
      await getAllProducts();
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment(int i) {
    productList[i].counter++;
   productList[i].totalPrice=productList[i].counter * double.parse(productList[i].price);
    update();
  }
  void decrement(int i){
    if(productList[i].counter > 1 ){
      productList[i].counter--;
      productList[i].totalPrice=productList[i].counter * double.parse(productList[i].price);
      update();
    }
  }
  void setAgreedToOrder(bool newValue) {
    agreedToOrder.value = newValue;
    update();
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
  incrementQuantity() {
    if (this.quantity >= 10) {
      this.quantity = 10;
    } else {
      this.quantity += 1;
    }
  }

  decrementQuantity() {
    if (this.quantity <= 1) {
      this.quantity = 1;
    } else {
      this.quantity -= 1;
    }
  }

  Future<void> addToBasketAndBuyClickEvent(int i) async {
  try{
    basket=Basket(
      product_name: productList.elementAt(i).name,
      net_price: productList.elementAt(i).totalPrice.toString() !=null?productList.elementAt(i).totalPrice.toString() : productList.elementAt(i).price,
      quantity: productList.elementAt(i).counter.toString(),
      real_unit_price: productList.elementAt(i).price.toString(),
    );
    basketItems.add(basket);
    incrementQuantity();
    print(basketItems[0].product_name);
    print(basket.net_price);
    print('basket===');
  }catch(error){
 print(error);
  }
  Get.back();
  Get.reload();
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
