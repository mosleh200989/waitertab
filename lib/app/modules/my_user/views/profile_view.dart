import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waiter/app/global_widgets/CircularLoadingWidget.dart';
import 'package:waiter/app/global_widgets/ProfileAvatarWidget.dart';
import 'package:waiter/app/modules/my_user/controllers/my_user_controller.dart';

class ProfileView  extends StatelessWidget {
  MyUserController _con=Get.put(MyUserController());

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme.copyWith(dividerColor: Colors.transparent);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.accentColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'profile'.tr,
          style: Get.theme.textTheme.title.merge(TextStyle(letterSpacing: 1.3, color: Get.theme.primaryColor)),
        ),

      ),
      body: _con.userDb.username == null
          ? CircularLoadingWidget(height: 500)
          : SingleChildScrollView(
//              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: <Widget>[
            ProfileAvatarWidget(userdb: _con.userDb),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: Icon(
                Icons.person,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                'about'.tr,
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _con.userDb.id,
                style: Theme.of(context).textTheme.body1,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: Icon(
                Icons.shopping_basket,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                'recent_orders'.tr,
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            /* _con.recentOrders.isEmpty
                      ? CircularLoadingWidget(height: 200)
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: _con.recentOrders.length,
                          itemBuilder: (context, index) {
                            String orderStatusString='';
                            if(_con.recentOrders.elementAt(index).trans_status_id=='1') {
                              orderStatusString = 'orderReceived'.tr;
                            }
                            if(_con.recentOrders.elementAt(index).trans_status_id=='2') {
                              orderStatusString = 'Preparing'.tr;
                            }
                            if(_con.recentOrders.elementAt(index).trans_status_id=='3') {
                              orderStatusString = 'Ready'.tr;
                            }
                            if(_con.recentOrders.elementAt(index).trans_status_id=='4') {
                              orderStatusString = 'OnTheWay'.tr;
                            }
                            if(_con.recentOrders.elementAt(index).trans_status_id=='5') {
                              orderStatusString = 'delivered'.tr;
                            }
                            return Theme(
                              data: theme,
                              child:ExpansionTile(
                                initiallyExpanded: false,
                                title: Row(
                                  children: <Widget>[
                                    Expanded(child: Text('order_id'.tr +': #${_con.recentOrders.elementAt(index).trans_code}')),
                                    Text(
                                      '${orderStatusString}',
                                      style: Theme.of(context).textTheme.caption,
                                    ),


                                  ],
                                ),
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15)),
                                        primary:Get.theme.accentColor,
                                      ),

                                      child: Text(
                                        'order_details'.tr,
                                        style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: 16.0),
                                      ),

                                      onPressed: () {
                                *//*        Get.toNamed(Routes.OrderDetails,
                                            arguments: _con.recentOrders
                                                .elementAt(index)
                                                .id);*//*
                                      },
                                    ),
                                  ),
                                ],
                                *//*children: List.generate(_con.recentOrders.elementAt(index).productOrders.length, (indexProduct) {
                                  return OrderItemWidget(
                                      heroTag: 'recent_orders',
                                      order: _con.recentOrders.elementAt(index),
                                      productOrder: _con.recentOrders.elementAt(index).productOrders.elementAt(indexProduct));
                                }),*//*
                              ),

                            );
                          },
                        ),*/
          ],
        ),
      ),
    );
  }
}
