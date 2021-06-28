
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_url.dart';
import 'package:waiter/app/data/models/options.dart';
import 'package:waiter/app/data/models/product.dart';
import 'package:waiter/app/global_widgets/EmptyOrdersWidget.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';
import 'package:waiter/app/modules/product_list/controllers/product_list_controller.dart';

class ProductsItem extends StatelessWidget {
  final appCont=Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return GetX<ProductListController>(
        init: ProductListController(),
        builder: (controller) {
          print(controller.productList.length);
          print('controller.productList.length');
          /*   if (controller.isLoading.value)
            return Center(child: CircularProgressIndicator());
          else*/
          return  controller.productList.isEmpty ? EmptyOrdersWidget():RefreshIndicator(
            onRefresh: controller.refreshProductList,
            child: ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.productList.length,
              itemBuilder: (context, index) {
                if (index == controller.productList.length - 1 &&
                    controller.isMoreDataAvailable.value == true) {
                  return Center(child: CircularProgressIndicator());
                }
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          leading: GestureDetector(
                            child: CachedNetworkImage(
                              // height: 50,
                              width: Get.width * .14,
                              fit: BoxFit.fill,
                              imageUrl:"${controller.productList.elementAt(index).image_url??''}",
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            onTap: () {
                              showCustomDialogForImage(context,controller.productList.elementAt(index).image_url,controller.productList.elementAt(index).name);
                            },
                          ),

                          // CircleAvatar(
                          //   backgroundColor: Colors.white,
                          //   radius: 35.0,
                          //   child: ClipRRect(
                          //     borderRadius:BorderRadius.circular(50),
                          //     child: CachedNetworkImage(
                          //       // height: 50,
                          //       // width: 100,
                          //       fit: BoxFit.cover,
                          //       imageUrl:"${controller.productList.elementAt(index).image_url??''}",
                          //       errorWidget: (context, url, error) => Icon(Icons.error),
                          //     ),
                          //   ),
                          // ),
                          title: Text('${controller.productList.elementAt(index).name??''}'),
                          trailing: ElevatedButton.icon(
                            onPressed: () {
                              if(controller.productList.elementAt(index).isOrder==true) {
                                controller.setAgreedToOrder(false, index);
                              }else{
                                controller.clearOptionValue(index);
                                controller.incrementOpenDialog(index);
                                Get.defaultDialog(
                                  title: 'AddProduct'.tr,
                                  titleStyle: TextStyle(fontSize: 24),
                                  // backgroundColor: Colors.blueGrey,
                                  // barrierDismissible: false,
                                  content: SizedBox(
                                    width: Get.width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                              alignment:Get.locale.languageCode=='en'?Alignment.topLeft: Alignment.topRight,
                                              child: Text('${controller.productList.elementAt(index).name}')),
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [

                                              // Visibility(
                                              //     visible: controller.productList.elementAt(index).option!=null,
                                              //     child: Text('${controller.productList.elementAt(index).option}')),

                                              Expanded(
                                                flex:2,
                                                child: Obx(()=>
                                                    DropdownButton<OptionModel>(
                                                      isExpanded: true,
                                                      underline: SizedBox(),
                                                      icon: Icon(
                                                        Icons.arrow_drop_down_sharp,
                                                      ),
                                                        // (i == 1) ? 1 : (i == 2) ? 2 : 0
                                                      // condition== true ? 1 : stringName == "Steve" ? 0 : 2,
                                                      hint:_showOptionText(controller?.productList?.elementAt(index),controller),
                                                      // value: controller.optionValue,

                                                      items:controller?.productList?.elementAt(index)?.optionsList?.length  !=null ? controller?.productList?.elementAt(index)?.optionsList?.map((lang) {
                                                        return  DropdownMenuItem<OptionModel>(
                                                          child: Text(lang?.name??''),
                                                          value:lang,
                                                        );
                                                      })?.toList() : null,
                                                      // value:controller.optionValue??null,
                                                      onChanged: (OptionModel option) {
                                                        print(option.id);
                                                        controller.changedOption(option);
                                                      },
                                                    ),
                                                ),
                                              ),
                                              // Expanded(child: Obx(()=> Text(controller.optionValue??controller.productList.elementAt(index).option))),

                                              Expanded(
                                                flex:4,
                                                child: GetBuilder<ProductListController>(
                                                    builder: (_) {
                                                      // _.productList.elementAt(index).totalPrice=double.parse(_.productList.elementAt(index).price);
                                                      return Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          controller.dividerLabel,
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              // crossAxisAlignment: CrossAxisAlignment.end,
                                                              // mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    _.increment(index);
                                                                  },
                                                                  child: CircleAvatar(
                                                                      radius: 12,
                                                                      backgroundColor:Colors.grey,
                                                                      child: Icon(Icons.add,color: Colors.black,)),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.all(5.0),
                                                                  child: Text('${controller.productList.elementAt(index).counter.toString()??''}',textAlign: TextAlign.center,),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    _.decrement(index);
                                                                  },
                                                                  child: CircleAvatar(
                                                                      radius: 12,
                                                                      backgroundColor:Colors.grey,
                                                                      child: Icon(Icons.remove,color: Colors.black,)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          controller.dividerLabel,
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text('${_.productList.elementAt(index).totalPrice??_.productList.elementAt(index).price}',),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // textCancel: 'dismiss'.tr,
                                  // cancelTextColor:Colors.white,
                                  // onCancel: () {
                                  // },
                                  textConfirm: 'ADD_TO_CART'.tr,
                                  confirmTextColor:Colors.white,
                                  onConfirm: () {
                                    controller.addToBasketAndBuyClickEvent(index);
                                  },

                                  buttonColor:Colors.grey ,
                                );
                              }
                            },
                            icon: Icon(Icons.shopping_cart),
                            label: Text(controller.productList.elementAt(index).isOrder==true?'AlreadyAdded'.tr : 'AddProduct'.tr),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey
                            ),

                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${controller.productList.elementAt(index).net_price??''}'),
                              // Text('${controller.productList.elementAt(index).tax_rate.name??''}'),
                              Text('${controller.productList.elementAt(index).unit.name??''}'),
                              // Text('${controller.productList.elementAt(index).options[0].quantity??''}'),
                              // Text('Although the legendary Double Although the legendary Double Although the legendary Double' ),
                              Text('${controller.productList.elementAt(index).price??''} SAR',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.red),),
                              SizedBox(height: 10,),
                            ],),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 0.0,
                    //     right: 0.0,
                    //     child:
                    //        Checkbox(
                    //             value: controller.productList.elementAt(index).isOrder,
                    //             onChanged: (value) {
                    //               controller.setAgreedToOrder(value,index);
                    //         }
                    //
                    //     ),),
                    /*     Positioned(
                    bottom: 10.0,
                    right: Get.locale.languageCode=="en"? 5 :Get.width-130,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if(controller.productList.elementAt(index).isOrder==true) {
                          controller.setAgreedToOrder(false, index);
                        } else{
                          controller.incrementOpenDialog(index);
                          Get.defaultDialog(
                            title: 'AddProduct'.tr,
                            titleStyle: TextStyle(fontSize: 24),
                            // backgroundColor: Colors.blueGrey,
                            // barrierDismissible: false,
                            content: SizedBox(
                              width: Get.width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Text('${controller.productList.elementAt(index).name}')),
                                    controller.dividerLabel,
                                    Visibility(
                                        visible: controller.productList.elementAt(index).option!=null,
                                        child: Text('${controller.productList.elementAt(index).option}')),

                                    DropdownButton(
                                      underline: SizedBox(),
                                      icon: Icon(
                                        Icons.arrow_drop_down_sharp,
                                      ),
                                      items:controller.productList.elementAt(index).optionsList !=null? controller.productList.elementAt(index).optionsList.map((lang) {
                                        return  DropdownMenuItem<dynamic>(
                                          value: lang.name,
                                          child: Text(lang.name??'20.0'),
                                        );
                                      }).toList(): null,

                                      onChanged: (val) {
                                        print(val);
                                      },
                                    ),
                                    controller.dividerLabel,
                                    GetBuilder<OrderDetailsController>(
                                        builder: (_) {
                                          // _.productList.elementAt(index).totalPrice=double.parse(_.productList.elementAt(index).price);
                                          return Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        _.increment(index);
                                                      },
                                                      child: CircleAvatar(
                                                          radius: 12,
                                                          backgroundColor:Colors.grey,
                                                          child: Icon(Icons.add,color: Colors.black,)),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: Text('${controller.productList.elementAt(index).counter.toString()??''}',textAlign: TextAlign.center,),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        _.decrement(index);
                                                      },
                                                      child: CircleAvatar(
                                                          radius: 12,
                                                          backgroundColor:Colors.grey,
                                                          child: Icon(Icons.remove,color: Colors.black,)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              controller.dividerLabel,
                                              Text('${_.productList.elementAt(index).totalPrice??_.productList.elementAt(index).price}'),
                                            ],
                                          );
                                        }
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            // textCancel: 'dismiss'.tr,
                            // cancelTextColor:Colors.white,
                            // onCancel: () {
                            // },
                            textConfirm: 'ADD_TO_CART'.tr,
                            confirmTextColor:Colors.white,
                            onConfirm: () {
                              controller.addToBasketAndBuyClickEvent(index);
                            },

                            buttonColor:Colors.grey ,
                          );
                        }
                      },
                      icon: Icon(Icons.shopping_cart),
                        label: Text(controller.productList.elementAt(index).isOrder==true?'AlreadyAdded'.tr : 'AddProduct'.tr),
                      style: ElevatedButton.styleFrom(
                         primary: Colors.grey
                      ),

                    ),
                  )*/
                    /*    GetBuilder<OrderDetailsController>(
                        builder: (_) {
                          return Positioned(
                              bottom:10.0,
                              right: 10.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _.increment(index);

                                      },
                                      child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor:Colors.grey,
                                          child: Icon(Icons.add,color: Colors.black,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text('${controller.productList.elementAt(index).counter.toString()??''}',textAlign: TextAlign.center,),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _.decrement(index);
                                      },
                                      child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor:Colors.grey,
                                          child: Icon(Icons.remove,color: Colors.black,)),
                                    ),
                                  ],
                                ),
                              ));
                        }
                      ),*/
                  ],
                );
              },),
          );
        }
    );
  }
  Widget _showOptionText(Product product,ProductListController controller) {
    // Text(controller.optionValue!=''?controller.optionValue:controller.productList.elementAt(index).optiontext!=null?controller.optionValue:controller.productList.elementAt(index).optiontext : '')
    if (controller.optionValue != '') {
      return Text('${controller.optionValue}');
    } else if(product.optiontext!=null) {
      return Text('${product.optiontext}');
    } else {
      return Text("");
    }
  }
  void showCustomDialogForImage(BuildContext context,String img,String name) {
    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 400.0,
        width: Get.width,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 350,
              padding: EdgeInsets.only(top: 60,right: 20,left: 20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  height: 25,
                  width:25,
                  fit: BoxFit.fill,
                  imageUrl:img,
                  errorWidget: (context, url, error) => Image.network('${MrUrl.get_no_image_url}'),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Align(
              // These values are based on trial & error method
              alignment: Alignment(1.05, -1.05),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }

}

class OrderItemController {
  int counter;
  OrderItemController(this.counter);
}