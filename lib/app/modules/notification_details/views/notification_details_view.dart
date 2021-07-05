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
          child: GetX<NotificationDetailsController>(
              builder: (_con) {
            if (_con.isLoading.value)
              return Center(child: CircularProgressIndicator());
            else
            if(_con.notification == null){
              return EmptyOrdersWidget();
            }else{
              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:<Widget> [
                        Expanded(
                          flex: 2,
                          child: Text('Id'.tr+':',
                            style: labelTextStyle,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text('${_con.notification.id??""}',
                            style: labelTextStyle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children:<Widget> [
                        Expanded(
                          flex: 2,
                          child: Text('Title'.tr+':',
                            style: labelTextStyle,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text('${_con.notification.title??""}',
                            style: labelTextStyle,  textAlign: TextAlign.start
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children:<Widget> [
                        Expanded(
                          flex: 2,
                          child: Text('Date'.tr+':',
                            style: labelTextStyle,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text('${_con.notification.date??""}',
                            style: labelTextStyle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:<Widget> [
                        Expanded(
                          flex: 2,
                          child: Text('Comment'.tr+':',
                            style: labelTextStyle,  textAlign: TextAlign.start,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text('${_con.notification.comment??""}',
                            style: labelTextStyle,
                          ),
                        ),
                      ],
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
