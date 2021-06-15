
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   SizedBox(height: 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex:2,
            child: Text('Name'.tr,textAlign: TextAlign.center,),),
          Expanded(
            flex:2,
            child: Text('Date'.tr,textAlign: TextAlign.center,),),
          Expanded(
            flex:2,
            child: Text('Status'.tr,textAlign: TextAlign.center,),),
        ],
      ),
    );
  }
}
