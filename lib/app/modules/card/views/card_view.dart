import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/card_controller.dart';

class CardView extends GetView<CardController> {
  @override
  Widget build(BuildContext context) {
    final TextStyle labelTextStyle=TextStyle(fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: Text('Card'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade200,
      body:SafeArea(
        child: Wrap(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(5),
              elevation: 5,             
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget>[
                  Expanded(child: Text('Cart Info',style: labelTextStyle,)),
                  Expanded(child: Text('Size',style: labelTextStyle,)),
                    Expanded(child: Text('Unit Price',style: labelTextStyle,)),
                    Expanded(child: Text('Quantity',style: labelTextStyle,)),
                    Expanded(child: Text('Total Price',style: labelTextStyle,)),
                ],),
              ),
            ),
            SizedBox(height: 10,),
            Card(
              margin: EdgeInsets.all(5),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget> [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget>[
                        Expanded(child: Text('Bangla Set Menu Rice Boart',style: labelTextStyle,)),
                        Expanded(child: Text('50',style: labelTextStyle,)),
                        Expanded(child: Text('Tk 25.00',style: labelTextStyle,)),
                        Expanded(child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.increment();
                              },
                              child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor:Colors.grey,
                                  child: Icon(Icons.add,color: Colors.black,)),
                            ),
                            Obx(()=> Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text('${controller.count}',textAlign: TextAlign.center,),
                            ) ),
                            InkWell(
                              onTap: () {
                                controller.decrement();
                              },
                              child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor:Colors.grey,
                                  child: Icon(Icons.remove,color: Colors.black,)),
                            ),
                          ],
                        ),),
                        Expanded(child: Text('Tk 25.00',style: labelTextStyle,)),
                      ],),
                    Card(
                      elevation: 5,
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          shape:StadiumBorder(),
                        ),
                          onPressed: () {

                          },
                          icon: Icon(Icons.arrow_drop_down,),
                          label: Text('Notes')),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
