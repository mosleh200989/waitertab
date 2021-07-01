import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waiter/app/global_widgets/EmptyOrdersWidget.dart';

import '../controllers/notification_details_controller.dart';

class NotificationDetailsView extends GetView<NotificationDetailsController> {
  @override
  Widget build(BuildContext context) {
    final TextStyle labelTextStyle = TextStyle(fontWeight: FontWeight.w500,fontSize: 15.0,);

    return Scaffold(
      appBar: AppBar(
        title: Text('NotificationDetails'.tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: GetX<NotificationDetailsController>(builder: (_con) {
            if (_con.isLoading.value)
              return Center(child: CircularProgressIndicator());
            else
            if(_con.notification == null){
              return EmptyOrdersWidget();
            }else{
              return  Card(
                margin: EdgeInsets.all(10),
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Id'.tr+': ${_con.notification.id??""}',
                      style: labelTextStyle,
                    ),
                    Text('Date'.tr+': ${_con.notification.date??""}',
                      style: labelTextStyle,
                    ),
                    Text('FromDate'.tr+': ${_con.notification.from_date??""}',
                      style: labelTextStyle,
                    ),
                    Text(
                      'TillDate'.tr+': ${_con?.notification?.till_date??''}',
                      style: labelTextStyle,
                    ),
                    Text(
                      'Comment'.tr+': ${_con?.notification?.comment??''}',
                      style: labelTextStyle,
                    ),

                  ],
                ),
              );
            }

          }),
        ),
      ),
    );
  }
}
