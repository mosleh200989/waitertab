

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_url.dart';
import 'package:waiter/app/global_widgets/helpers.dart';
import 'package:waiter/app/modules/order_details/views/local_widgets/all_order_card_page.dart';
import 'package:waiter/app/routes/app_pages.dart';

import '../controllers/order_details_controller.dart';

class OrderDetailsView extends GetWidget<OrderDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 200,
                      width: Get.width,
                      child: CachedNetworkImage(
                        // height: 100,
                        // width: Get.width,
                        fit: BoxFit.fill,
                        imageUrl:"${controller.imageUrl??''}",
                        errorWidget: (context, url, error) => Image.network('${MrUrl.get_no_image_url}'),
                      ),
                      // Image(image: AssetImage('assets/images/burger_1.jpg'),  fit: BoxFit.fill,width: Get.width,)
                  ),
                ),
                Positioned(
                  top: 5.0,
                    right:5.0,
                    child: InkWell(
                      onTap: () => Get.back(),
                        child: Icon(Icons.keyboard_arrow_right))),
              ],
            ),
            Card(
              elevation: 2,
              child: Container(
                height: 50,
                color: Colors.white,
                width: Get.width,
                child: Obx(()=>Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 12.0),
                  child: Text('${controller.productName??''}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ))
              ),
            ),
            Expanded(
              child: AllOrderCarPage(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          color: Get.theme.primaryColor,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(()=>
                   CircleAvatar(
                    radius: 10,
                    // backgroundColor: Colors.green,
                    child: Text('${controller.cartQuantity}'),
                  ),
                ),
                Text('ViewYourCart'.tr,style: TextStyle(color: Colors.white,fontSize: 18),),
                Obx(()=> Text('${controller.busketTotal.toString()} SAR',style: TextStyle(color: Colors.white),)),
              ],
            ),
          ),
        ),
        onTap: () {
          if(controller.cartQuantity !=0){
            Get.toNamed(Routes.CARD);
          }else{
            Helpers.showSnackbar(title:'error'.tr,message: 'warning_dialog_please_add_to_card'.tr);
          }

        },
      ),
    );
  }
}
