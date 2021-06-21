import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:waiter/app/core/values/mr_constants.dart';
import 'package:waiter/app/data/models/basket.dart';
import 'package:waiter/app/data/models/options.dart';
import 'package:waiter/app/data/models/pagination_filter.dart';
import 'package:waiter/app/data/models/product.dart';
import 'package:waiter/app/data/providers/order_details_provider.dart';
import 'package:waiter/app/global_widgets/helpers.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';
class ProductListController extends GetxController {
  final AppController appController=Get.find();
  final AuthController authController=Get.find();
  var isLoading = true.obs;
  var isDataProcessing = true.obs;
  var productList = <Product>[].obs;
  final Widget dividerLabel=  Container( height: 30.0,width: 2.0, color: Colors.grey,);
  var product=Product().obs;
  var counter = <int>[].obs;
  TabController tabController;
  var _busketTotal=0.0.obs;
  double get busketTotal=> _busketTotal.value;

  final count = 1.obs;
  final agreedToOrder = false.obs;
  final catId=''.obs;
  final imageUrl=''.obs;
  final productName=''.obs;
  final _quantity = 0.obs;
  set quantity(int value) => _quantity.value = value;
  int get quantity => _quantity.value;

  int get cartQuantity {
    return appController.basketItems.length;
  }
  final _grandTotal=0.0.obs;
  double get grandTotal=>_grandTotal.value;
  var _optionValue=''.obs;
  var _optionId=''.obs;
  String get optionValue=>_optionValue.value;
  String get optionId=>_optionId.value;
  String optionData='';

// For Pagination
  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = true.obs;
  final _paginationFilter = PaginationFilter().obs;
  int get limit => _paginationFilter.value.limit;
  int get offset => _paginationFilter.value.offset;
  // final selectedItemValue = [].obs;
  final _selectedItemValue = <String>[].obs;
  List<String> get selectedItemValue=>_selectedItemValue.value;

  @override
  void onInit()async {
    _changePaginationFilter(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    if(Get.arguments !=null && Get.arguments.length>0){
      catId.value=Get.arguments['catId'];
      imageUrl.value=Get.arguments['image_url'];
      productName.value=Get.arguments['product_name'];
      print(catId);
      print('catId');
      // ever(_paginationFilter, (_) async =>  await getAllProducts());
      await getAllProducts(_paginationFilter.value);
    }
    // incrementGrandTotal();
    for(var i=0; i<appController.basketItems.length;i++){
      print(appController.basketItems[i].unit_price);
      _busketTotal.value =_busketTotal.value + double.parse(appController.basketItems[i].subtotal);
      // _optionValue.value=appController.basketItems[i].product_option;
    }
    print("busketTotal==");
    print(busketTotal);
    //For Pagination
    paginateProductList();
    for (int i = 0; i < 20; i++) {
      _selectedItemValue.add("NONE");
    }
    super.onInit();
  }

  @override
  void onReady() {
    print('or ready order controller');
    super.onReady();
  }

  @override
  void onClose() {}
  void _changePaginationFilter(int offset, int limit) {
    _paginationFilter.update((val) {
      val.offset = offset;
      val.limit = limit;
    });

  }
  // For Pagination
  void paginateProductList() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("reached end");
        _changePaginationFilter(offset + limit, limit);
        await getMoreProducts(_paginationFilter.value);
        // page++;
        // getMoreTask(page);
      }
    });
  }
  Future<void> refreshProductList() async {
    productList.clear();
    _changePaginationFilter(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    await getAllProducts(_paginationFilter.value);
    Helpers.showSnackbar(title:'success'.tr,message: 'refreshed_successfully_completed'.tr);
  }
  void increment(int i) {
    productList[i].counter++;
    productList[i].totalPrice=productList[i].counter * double.parse(productList[i].price);
    update();
  }
  void changedOption(OptionModel value){
    _optionValue.value=value.name;
    _optionId.value=value.id;
  }
  void clearOptionValue(int index){
    _optionValue.value='';
    _optionId.value='';
    bool checkOption=false;
    for(var i=0; i<appController.basketItems.length; i++){
      if(appController.basketItems[i].product_id == productList[index].id){
        _optionValue.value=appController.basketItems[i].optionValue;
        _optionId.value=appController.basketItems[i].product_option;
        print('option condition');
        break;
      }
    }
    appController.basketItems.refresh();
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
          _busketTotal.value -= double.parse(appController.basketItems[i].subtotal);
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
  Future<void> getAllProducts(PaginationFilter filter) async {
    try {
      if(await authController.checkInternetConnectivity()) {
        isMoreDataAvailable(false);
        isDataProcessing(true);
        var products = await OrderDetailsProvider().getProduct(
            catId.value, filter);
        if (products != null) {
          productList.addAll(products);
          isDataProcessing(false);
          // categoriesList.value = categories;
        } else {
          print('product null');
        }
      }else{
        Helpers.showSnackbar(title:'error',message: 'error_dialog__no_internet'.tr);
      }
    } finally {
      isDataProcessing(false);
    }
  }

  Future<void> getMoreProducts(PaginationFilter filter) async {
    try {
      var products = await OrderDetailsProvider().getProduct(catId.value,filter);
      if (products.length > 0) {
        isMoreDataAvailable(true);
      } else {
        isMoreDataAvailable(false);
      }
      productList.addAll(products);
    }catch (exception) {
      isDataProcessing(false);
    }finally{
      isDataProcessing(false);
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
    print("index==$index");
    try{
      Basket basket=Basket(
        product_id: productList.elementAt(index).id,
        product_name: productList.elementAt(index).name,
        net_price: productList[index].net_price,
        quantity: productList.elementAt(index).counter.toString(),
        product_base_quantity: productList.elementAt(index).counter.toString(),
        real_unit_price: productList.elementAt(index).price,
        product_code: productList.elementAt(index).code,
        product_option: optionId==''?productList.elementAt(index).option:optionId,
        optionValue: optionValue==''?productList.elementAt(index).optiontext:optionValue,
        product_tax: productList.elementAt(index).tax_rate.id,
        unit_price: productList.elementAt(index).unit_price,
        product_unit: productList.elementAt(index).unit.id,
        product_discount: '0',
        item_discount: '0.0',
        subtotal: productList[index].totalPrice.toString() ?? productList[index].price,
      );
      print(basket.toMap());
      print('basket');
      // setAgreedToOrder(true, index);
      if(appController.basketItems.length>0) {
        print("appController.basketItems.length=${appController.basketItems.length}");
        int busketLength=appController.basketItems.length;
        bool foundBusket=false;
        for (var i = 0; i < busketLength; i++) {
          print("looping i=$i");
          print(appController.basketItems[i].product_id+"====="+productList[index].id);
          print('prodic id=======');

          if (appController.basketItems[i].product_id == productList[index].id) {
            print(appController.basketItems[i].product_id+"====="+productList[index].id);
            print('inside if');

            // print('if contains');
            // Helpers.showSnackbar(message: 'warning_dialog__input_password'.tr);
            // Get.toNamed(Routes.CARD);
            appController.basketItems[i].quantity=(int.parse(appController.basketItems[i].quantity)+productList.elementAt(index).counter).toString();
            appController.basketItems[i].product_base_quantity=(int.parse(appController.basketItems[i].product_base_quantity)+productList.elementAt(index).counter).toString();
            appController.basketItems[i].subtotal =(int.parse(appController.basketItems[i].quantity) * double.parse(productList[index].price)).toString() ;
            appController.basketItems[i].product_option =optionId;
            appController.basketItems[i].optionValue =optionValue;
            // appController.basketItems.canUpdate;
            print('if contains');
            // appController.basketItems.refresh();
            foundBusket=true;
            break;
          }
        }

        if(!foundBusket){
          appController.basketItems.add(basket);
        }
        appController.basketItems.refresh();
      }else{
        appController.basketItems.add(basket);
        print('else =========contains');
      }

      _busketTotal.value=0.0;
      for(var i=0; i< appController.basketItems.length; i++){
        // if(i==index){
        // _busketTotal.value+= double.parse(appController.basketItems[i].subtotal);
        // _busketTotal.value
        print(appController.basketItems[i].unit_price);
        _busketTotal.value =_busketTotal.value + double.parse(appController.basketItems[i].subtotal);
        // _optionValue.value=appController.basketItems[i].product_option;
        // }
        update();
      }
      // for(var i=0; i<appController.basketItems.length;i++){
      //
      // }
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
