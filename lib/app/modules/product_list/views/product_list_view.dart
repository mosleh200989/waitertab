import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_url.dart';
import 'package:waiter/app/global_widgets/helpers.dart';
import 'package:waiter/app/modules/product_list/controllers/product_list_controller.dart';
import 'package:waiter/app/modules/product_list/views/local_widgets/products_item.dart';
import 'package:waiter/app/routes/app_pages.dart';

class ProductListView extends GetWidget<ProductListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Products'.tr),
        actions: [
             TextButton(
            onPressed: () {
              Get.offAndToNamed(Routes.NOTIFICATIONS);
              // Get.offNamed(Routes.NOTIFICATION_PAGE, arguments: 0);
            },
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Icon(
                  Icons.notification_important_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                Container(
                  child:  Text('0',
                    textAlign: TextAlign.center,
                    style: Get.theme.textTheme.caption.merge   (
                      TextStyle(color: Colors.black, fontSize: 12,fontWeight: FontWeight.normal),
                    ),
                  ),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(color: Colors.blueGrey.shade200, borderRadius: BorderRadius.all(Radius.circular(10))),
                  constraints: BoxConstraints(minWidth: 15, maxWidth: 80, minHeight: 15, maxHeight: 50),
                ),
              ],
            ),
            // color: Colors.transparent,
          ),
          TextButton(
            onPressed: () {
              // Get.offNamed(Routes.NOTIFICATION_PAGE, arguments: 0);
            },
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                Container(
                  child: Obx(() {
                    return Text('${controller.busketTotal.toStringAsFixed(0).toString()??0}',
                      textAlign: TextAlign.center,
                      style: Get.theme.textTheme.caption.merge(
                        TextStyle(color: Colors.black, fontSize: 12,fontWeight: FontWeight.normal),
                      ),
                    );
                  }),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(color: Colors.blueGrey.shade200, borderRadius: BorderRadius.all(Radius.circular(10))),
                  constraints: BoxConstraints(minWidth: 15, maxWidth: 80, minHeight: 15, maxHeight: 50),
                ),
              ],
            ),
            // color: Colors.transparent,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 150,
                    width: Get.width,
                    child: CachedNetworkImage(
                      // height: 100,
                      // width: Get.width,
                      // fit: BoxFit.fill,
                      imageUrl:"${controller.imageUrl??''}",
                      errorWidget: (context, url, error) => Image.network('${MrUrl.get_no_image_url}'),
                    ),
                    // Image(image: AssetImage('assets/images/burger_1.jpg'),  fit: BoxFit.fill,width: Get.width,)
                  ),
                ),
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
              child: ProductsItem(),
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