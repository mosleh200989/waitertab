import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waiter/app/global_widgets/DrawerWidget.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';
import 'package:waiter/app/modules/home/controllers/dialogcontroller_controller.dart';
import 'package:waiter/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';


class HomeView extends GetWidget<HomeController> {
  final DialogcontrollerController cond = Get.put(DialogcontrollerController());
  final AuthController authCont = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    double height = Get.size.height;
    double width = Get.size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Menu'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.rice_bowl),
            color: Colors.white,
            onPressed: () {
              print('android');
            },
          ),
          TextButton(
            onPressed: () {
              // Get.offNamed(Routes.NOTIFICATION_PAGE, arguments: 0);
            },
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 28,
                ),
                Container(
                  child: Text('10',
                    textAlign: TextAlign.center,
                    style: Get.theme.textTheme.caption.merge(
                      TextStyle(color: Colors.black, fontSize: 10,),
                    ),
                  ),
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(color: Colors.orange.shade200, borderRadius: BorderRadius.all(Radius.circular(10))),
                  constraints: BoxConstraints(minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
                ),
              ],
            ),
            // color: Colors.transparent,
          ),
        ],
      ),
      drawer: DrawerWidget(),
    /*  body: GetBuilder<HomeController>(
        builder: (controller) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: controller.textController,
                  decoration: InputDecoration(
                    hintText: 'Search Here...',
                  ),
                  onChanged: (value) {
                    print(value);
                    print('value');
                    controller.onItemChanged(value.toString());
                    controller.updateFunction();

                    // Apply Search Bar Filter on ListView in Flutter Android iOS Example Tutorial
                  },
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(12.0),
                  children: controller.newDataList.map((data) {
                    return ListTile(
                      title: Text('${data}'),
                      onTap: ()=> print(data),);
                  }).toList(),
                ),
              )
            ],
          );
        }
      ),*/
      body: Column(
        children: [
          SizedBox(height: 100,),
        Obx(() {
      if (controller.isLoading.value)
        return Center(child: CircularProgressIndicator());
      else
          return Expanded(
              child: Container(
                // height: Get.height *.70,
                child: GridView.builder(
                  itemCount: controller.categoriesList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                      childAspectRatio: width / (height / 2)
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => Get.toNamed(Routes.ORDER_DETAILS,arguments: {'catId':controller.categoriesList.elementAt(index).id} ),
                      child: Card(
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Image(image: AssetImage('assets/images/burger_1.jpg'),  fit: BoxFit.fill,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${controller.categoriesList.elementAt(index).name}',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18 ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                  ),
              ),
            );},
          ),
        ],
      ),
    );
  }
}
