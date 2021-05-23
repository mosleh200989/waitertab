

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/modules/order_details/controllers/order_details_controller.dart';

class SaladCarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderDetailsController>();
    return ListView.builder(
      itemCount: 5,
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
                          child:Image(image: AssetImage('assets/images/burger_1.jpg'),  fit: BoxFit.cover,width:70,height: 80,),
                        ),

                      ),
                      title: Text('Bangla Set Menu Roce Boart'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('1:2'),
                          Text('Although the legendary Double Although the legendary Double Although the legendary Double' ),
                          Text('Tk 300.00',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.red),),
                          SizedBox(height: 10,),
                        ],),
                    ),
                  ),
                ),
                onTap: () {
                  controller.setAgreedToOrder(true);
                  Get.defaultDialog(
                    title: 'add_ons'.tr,
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
                              Text('delivery_boy'.tr + ' : ',style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('service'.tr + ' : ',style: TextStyle(color: Colors.white),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('price'.tr +' : ',style: TextStyle(color: Colors.white),),

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
              Positioned(
                top: 0.0,
                  left: 0.0,
                  child:Obx(()=>Checkbox(
                    value: controller.agreedToOrder.value,
                    onChanged: (value) {
                      controller.setAgreedToOrder(value);
                    },
                  ),)),
              Positioned(
                  bottom:10.0,
                  left: 10.0,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.increment(index);
                        },
                        child: CircleAvatar(
                            radius: 12,
                            backgroundColor:Colors.grey,
                            child: Icon(Icons.add,color: Colors.black,)),
                      ),
                      Obx(()=> Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('${controller.count}',textAlign: TextAlign.center,),
                      ) ),
                      InkWell(
                        onTap: () {
                          controller.decrement(index);
                        },
                        child: CircleAvatar(
                            radius: 12,
                            backgroundColor:Colors.grey,
                            child: Icon(Icons.remove,color: Colors.black,)),
                      ),
                    ],
                  )),
            ],
          );
        },);
  }
}