

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/options.dart';
import 'package:waiter/app/global_widgets/EmptyOrdersWidget.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';
import 'package:waiter/app/modules/order_details/controllers/order_details_controller.dart';

class AllOrderCarPage extends StatelessWidget {
  final appCont=Get.find<AppController>();

  @override
  Widget build(BuildContext context) {

    return GetX<OrderDetailsController>(
      init: OrderDetailsController(),
      builder: (controller) {
        print(controller.productList.length);
        print('controller.productList.length');
          if (controller.isLoading.value)
            return Center(child: CircularProgressIndicator());
          else
          return  controller.productList.isEmpty ? EmptyOrdersWidget():RefreshIndicator(
            onRefresh: controller.refreshProductList,
            child: ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.productList.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: CachedNetworkImage(
                              // height: 50,
                              width: Get.width * .14,
                              fit: BoxFit.fill,
                              imageUrl:"${controller.productList.elementAt(index).image_url??''}",
                              errorWidget: (context, url, error) => Icon(Icons.error),
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
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${controller.productList.elementAt(index).name}'),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // Visibility(
                                                //     visible: controller.productList.elementAt(index).option!=null,
                                                //     child: Text('${controller.productList.elementAt(index).option}')),


                                                // DropdownButton<String>(
                                                //     underline: SizedBox(),
                                                //     icon: Icon(
                                                //       Icons.arrow_drop_down_sharp,
                                                //     ),
                                                //   // value:controller.optionValue,
                                                //   onChanged: (val) {
                                                //     print(val);
                                                //     controller.changedOption(val);
                                                //
                                                //   },
                                                //     items:controller.productList.elementAt(index).optionsList.length !=null ? controller.productList.elementAt(index).optionsList.map((lang) {
                                                //       return  DropdownMenuItem<String>(
                                                //         child: Text(lang.name??''),
                                                //         value:lang.name??"",
                                                //       );
                                                //     }).toList(): null,
                                                //
                                                //   ),

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

}

class OrderItemController {
  int counter;
  OrderItemController(this.counter);
}