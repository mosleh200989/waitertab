import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            children:<Widget> [
              SizedBox(height: 100,),
              Image(image: AssetImage('assets/images/welcome.png'),fit: BoxFit.fill,),
              SizedBox(height: 30,),
              Image(image: AssetImage('assets/images/waiter_img.png'),  fit: BoxFit.fill,),
              SizedBox(height: 100,),
            ],
          ),
        ),
      ),
    );
  }
}
