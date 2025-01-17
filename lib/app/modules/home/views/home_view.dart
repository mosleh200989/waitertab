import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:waiter/app/core/values/mr_url.dart';
import 'package:waiter/app/global_widgets/DrawerWidget.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';
import 'package:waiter/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:waiter/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {
  final AuthController authCont = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    double height = Get.size.height;
    double width = Get.size.width;
    // print(Get.key.currentState);
    // print(Get.key.currentState.canPop());
    // print(Get.key.currentState.maybePop());
    // print('home====');
    return WillPopScope(
      onWillPop: () {
        return  Get.defaultDialog(
          title: 'ConfirmExit'.tr,
          titleStyle: TextStyle(fontSize: 24),
          backgroundColor: Colors.grey.shade100,
          // barrierDismissible: false,
          content: Container(
            width: Get.width * 0.80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Are_you_sure_you_want_to_exit'.tr),
                ],
              ),
            ),
          ),
          confirm: Row(
            children:<Widget> [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {

                    Get.back();
                  }, child: Text('Cancel'.tr),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey.shade400,
                      fixedSize: Size(100, 20)
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (GetPlatform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (GetPlatform.isIOS) {
                      exit(0);
                    }

                  }, child: Text('Close'.tr),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey.shade400,
                      fixedSize: Size(100, 20)

                  ),),
              ),
            ],
          ),
          buttonColor:Colors.grey ,
          barrierDismissible: false,
          // onWillPop: () {
          //   return ;
          // },

        );
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          title: Text('Categories'.tr),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                // Get.reload<NotificationsController>(force: true,);
                // Get.delete<NotificationsController>();
                Get.find<NotificationsController>().refreshNotificationList();
                Get.toNamed( Routes.NOTIFICATIONS);
              },
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Icon(
                    Icons.notification_important_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                  Obx(() {
                    return Container(
                    child:  Text('${authCont.inReadCount.toString()??''}',
                      textAlign: TextAlign.center,
                      style: Get.theme.textTheme.caption.merge   (
                        TextStyle(color: Colors.black, fontSize: 12,fontWeight: FontWeight.normal),
                      ),
                    ),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(color: Colors.blueGrey.shade200, borderRadius: BorderRadius.all(Radius.circular(10))),
                    constraints: BoxConstraints(minWidth: 15, maxWidth: 80, minHeight: 15, maxHeight: 50),
                  );
}),
                ],
              ),
              // color: Colors.transparent,
            ),
          ],
        ),
        drawer: DrawerWidget(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
          Obx(() {
        if (controller.isLoading.value)
          return Center(child: CircularProgressIndicator());
        else
            return Expanded(
                child: GridView.builder(
                  itemCount: controller.categoriesList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                      childAspectRatio: width / (height * 0.60)
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        // Get.reload<OrderDetailsController>(force: true);
                        Get.toNamed(Routes.PRODUCT_LIST,arguments: {'catId':controller.categoriesList.elementAt(index).id,
                          'image_url':controller.categoriesList.elementAt(index).image,
                          'product_name':controller.categoriesList.elementAt(index).name,
                        });
                      },
                      child: Card(
                        elevation: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // SizedBox(height: 50,),
                            CachedNetworkImage(
                              height: 100,
                              width: 120,
                              fit: BoxFit.fill,
                              imageUrl:"${controller.categoriesList.elementAt(index).image??''}",
                              errorWidget: (context, url, error) => Image.network('${MrUrl.get_no_image_url}'),
                            ),
                            // Image(image: AssetImage('assets/images/burger_1.jpg'),  fit: BoxFit.fill,
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${controller.categoriesList.elementAt(index).name}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18 ),
                              ),
                            ),  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${Get.find<AppController>().htmlComment??''}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18 ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  ),
              );},
            ),
          ],
        ),
      ),
    );
  }
}
