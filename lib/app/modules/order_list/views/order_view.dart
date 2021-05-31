import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waiter/app/data/models/basket.dart';
import 'package:waiter/app/global_widgets/DrawerWidget.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';
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
          child: GetX<OrderListController>(
            builder: (_con) {
              print(_con.sales.biller);
              print('_con.sales.biller');
              if (_con.isLoading.value)
                return Center(child: CircularProgressIndicator());
              else
              return Card(
                margin: EdgeInsets.all(5),
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Sale Number: ${_con.sales.id}',style: labelTextStyle,),
                    Text('Date: ${_con.sales.date}',style: labelTextStyle,),
                    Text('Sale Reference: ${_con.sales.reference_no}',style: labelTextStyle,),
                    Text('Sales Associate: ${Get.find<AuthController>().currentUser.username}',style: labelTextStyle,),
                    SizedBox(height: 5,),
                    Text('Customer: ${_con.sales.customer}',style: labelTextStyle,),

                    SizedBox(height:20,),
                  Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount: _con.sales.items.length,
                        itemBuilder: (context, index) {
                        Basket items=_con.sales.items.elementAt(index);
                          return   Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:<Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:<Widget> [
                                  Text('#$index ${items.product_name}',style: labelTextStyle,),
                                  Text('${items.serial_no}',style: labelTextStyle,),
                                  Text('${double.parse(items.quantity).toStringAsFixed(2).toString()} X ${double.parse(items.unit_price).toStringAsFixed(2).toString()}',style: labelTextStyle,),
                               Container(color: Colors.black,width:Get.width*.48,height: 10,)
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children:<Widget> [
                                    Text(''),
                                    Text(''),
                                    Text('${double.parse(items.subtotal).toStringAsFixed(2).toString()}',style: labelTextStyle,),
                                    Container(color: Colors.black,width: Get.width*.48,height: 10,)
                                  ],
                                ),
                              ),
                            ],);
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
              );
            }
          ),
        ),
      ),
    );
  }
}
