import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tasks_controller.dart';

class TasksView extends GetView<TasksController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TasksView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TasksView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
