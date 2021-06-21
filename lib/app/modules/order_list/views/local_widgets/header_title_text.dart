
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderTitleText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex:2,
                child: Text('OrderNo'.tr,textAlign: TextAlign.center,style: TextStyle(fontSize: Get.theme.textTheme.bodyText1.fontSize),),),
              Expanded(
                flex:2,
                child: Text('CustomerName'.tr,textAlign: TextAlign.center,),),
              Expanded(
                flex:2,
                child: Text('Table'.tr,textAlign: TextAlign.center,),),
              Expanded(
                flex:2,
                child: Text('OrderDate'.tr,textAlign: TextAlign.center,),),
              Expanded(
                flex:2,
                child: Text('Amount'.tr,textAlign: TextAlign.center,),),
              Expanded(
                flex:2,
                child: Text('Action'.tr,textAlign: TextAlign.center,),),
            ],
          );
  }
}
