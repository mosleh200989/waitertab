import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notification_details_controller.dart';

class NotificationDetailsView extends GetView<NotificationDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotificationDetails'.tr),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NotificationDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
