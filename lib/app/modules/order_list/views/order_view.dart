import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waiter/app/global_widgets/DrawerWidget.dart';
import 'package:waiter/app/modules/order_details/views/local_widgets/all_order_card_page.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/cancel_order.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/complete_order.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/pending_order.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/processing_order.dart';

import '../controllers/order_list_controller.dart';

class OrderView extends GetView<OrderListController> {
  @override
  Widget build(BuildContext context) {
    final TextStyle labelTextStyle=TextStyle(fontWeight: FontWeight.bold);
    return Scaffold(
        drawer: DrawerWidget(),
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title:Obx(()=> Text('${controller.myHandler.value.title}')),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
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
                      Expanded(child: Text('Cart Info',textAlign: TextAlign.center,style: labelTextStyle,)),
                      Expanded(child: Text('Size',textAlign: TextAlign.center,style: labelTextStyle,)),
                      Expanded(child: Text('Unit Price',textAlign: TextAlign.center,style: labelTextStyle,)),
                      Expanded(child: Text('Quantity',textAlign: TextAlign.center,style: labelTextStyle,)),
                      Expanded(child: Text('Total Price',textAlign: TextAlign.center,style: labelTextStyle,)),
                      Expanded(child: Text('Status',textAlign: TextAlign.center,style: labelTextStyle,)),
                    ],),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 250,
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return  Card(
                      margin: EdgeInsets.all(5),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:<Widget> [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children:<Widget>[
                                Expanded(child: Text('Bangla Rice Boart',textAlign: TextAlign.center,style: labelTextStyle,)),
                                Expanded(child: Text('50',textAlign: TextAlign.center,style: labelTextStyle,)),
                                Expanded(child: Text('Tk 25.00',textAlign: TextAlign.center,style: labelTextStyle,)),
                                Expanded(child: Text('1',textAlign: TextAlign.center,style: labelTextStyle)),
                                Expanded(child: Text('Tk 25.00',textAlign: TextAlign.center,style: labelTextStyle,)),
                                Expanded(child: Text('Status',textAlign: TextAlign.center,style: labelTextStyle)),
                              ],),
                          ],
                        ),
                      ),
                    );
                  },),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text('Select Table : '),
                      Text('3'),
                    ],
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children:<Widget> [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget> [
                        Text('Customer Name'),
                        Card(
                          elevation: 5,
                          child: Container(
                              width: Get.width *.5,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 7.0,bottom: 7.0),
                                child: Text('Walkin',textAlign: TextAlign.center,),
                              )),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget> [
                        Text('Vat/Tax'),
                        Card(
                          elevation: 5,
                          child: Container(
                              width: Get.width *.5,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 7.0,bottom: 7.0),
                                child: Text('Tk 15',textAlign: TextAlign.center,),
                              )),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget> [
                        Text('Grand Total'),
                        Card(
                          elevation: 5,
                          child: Container(
                              width: Get.width *.5,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 7.0,bottom: 7.0),
                                child: Text('Tk 750.0',textAlign: TextAlign.center,),
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),





            ],
          ),
        ),
      ),
    );
  }
}
