import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/unknown_controller.dart';

class UnknownView extends GetView<UnknownController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UnknownView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'UnknownView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
