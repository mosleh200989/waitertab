import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/task_details_controller.dart';

class TaskDetailsView extends GetView<TaskDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskDetailsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TaskDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
