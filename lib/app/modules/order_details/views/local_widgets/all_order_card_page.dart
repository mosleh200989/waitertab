

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/modules/order_details/controllers/order_details_controller.dart';

class AllOrderCarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderDetailsController>();
    return Obx((){
      if (controller.isLoading.value)
        return Center(child: CircularProgressIndicator());
      else
      return ListView.builder(
        itemCount: controller.productList.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50.0,
                          child: ClipRRect(
                            borderRadius:BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              height: 100,
                              width: 120,
                              fit: BoxFit.cover,
                              imageUrl:"${controller.productList.elementAt(index).image_url??''}",
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        ),
                        title: Text('${controller.productList.elementAt(index).name??''}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${controller.productList.elementAt(index).net_price??''}'),
                            Text('${controller.productList.elementAt(index).tax_rate.name??''}'),
                            Text('${controller.productList.elementAt(index).unit.name??''}'),
                            // Text('${controller.productList.elementAt(index).options[0].quantity??''}'),
                            // Text('Although the legendary Double Although the legendary Double Although the legendary Double' ),
                            Text('Tk ${controller.productList.elementAt(index).price??''}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.red),),
                            SizedBox(height: 10,),
                          ],),
                      ),
                    ),
                  ),
                  onTap: () {
                    controller.setAgreedToOrder(true);
                    Get.defaultDialog(
                      // title: 'add_ons'.tr,
                      titleStyle: TextStyle(fontSize: 24,color: Colors.white),
                      backgroundColor: Colors.blueGrey,
                      barrierDismissible: false,
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${controller.productList.elementAt(index).name}',style: TextStyle(color: Colors.white)),
                                Visibility(
                                    visible: controller.productList.elementAt(index).option!=null,
                                    child: Text('${controller.productList.elementAt(index).option}',style: TextStyle(color: Colors.white))),
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
                                          Text('${_.productList.elementAt(index).totalPrice??_.productList.elementAt(index).price}',style: TextStyle(color: Colors.white)),
                                        ],
                                      );
                                    }
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                      textCancel: 'dismiss'.tr,
                      cancelTextColor:Colors.white,
                      onCancel: () {
                      },
                      textConfirm: 'submit'.tr,
                      confirmTextColor:Colors.white,
                      onConfirm: () {
                        Get.back();

                      },

                      buttonColor:Colors.grey ,
                    );
                  },
                ),
                // Positioned(
                //   top: 0.0,
                //     right: 0.0,
                //     child:Obx(()=>Checkbox(
                //       value: controller.agreedToOrder.value,
                //       onChanged: (value) {
                //         controller.setAgreedToOrder(value);
                //       },
                //     ),)),
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
          },);},
    );
  }
}
class OrderItemController {
  int counter;
  OrderItemController(this.counter);
}