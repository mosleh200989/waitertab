import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/product.dart';
import 'package:waiter/app/data/providers/order_details_provider.dart';

class OrderDetailsController extends GetxController  with SingleGetTickerProviderMixin{
  var isLoading = true.obs;
  var productList = <Product>[].obs;

  var product=Product().obs;
  var counter = <int>[].obs;
  TabController tabController;
  final count = 1.obs;
  final bike = ''.obs;
  final car = ''.obs;
  final agreedToOrder = false.obs;
  final catId=''.obs;
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
