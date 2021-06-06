import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waiter/app/data/models/basket.dart';
import 'package:waiter/app/global_widgets/DrawerWidget.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';
import 'package:waiter/app/modules/order_list/controllers/order_view_controller.dart';
import 'package:waiter/app/modules/order_list/views/local_widgets/label_and_text.dart';
import '../controllers/order_list_controller.dart';

class OrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle labelTextStyle = TextStyle(fontWeight: FontWeight.w500,fontSize: 15.0,);
    return Scaffold(
      // drawer: DrawerWidget(),
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title:  Text('OrderDetails'.tr),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: GetX<OrderViewController>(builder: (_con) {
            if (_con.isLoading.value)
              return Center(child: CircularProgressIndicator());
            else
              return Card(
                margin: EdgeInsets.all(5),
                elevation: 1,
                child: Stack(
                  children: [
                    Positioned(
                        right:  Get.locale.languageCode=="en"? 5:Get.width-40,
                        top: 5,
                        child: Container(
                            child: Icon(Icons.print)
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('SaleNumber'.tr+': ${_con.sales.id}',
                          style: labelTextStyle,
                        ),
                        Text('Date'.tr+': ${_con.sales.date}',
                          style: labelTextStyle,
                        ),
                        Text('SaleReference'.tr+': ${_con.sales.reference_no}',
                          style: labelTextStyle,
                        ),
                        Text(
                          'SalesAssociate'.tr+': ${Get.find<AuthController>().currentUser.username}',
                          style: labelTextStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Customer'.tr+': ${_con.sales.customer}',
                          style: labelTextStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: _con.sales.items.length !=0,
                          child: Container(
                            // height: 300,
                            child: ListView.builder(
                              shrinkWrap: true,
                              // physics: Scroll,
                              itemCount: _con.sales.items.length,
                              itemBuilder: (context, index) {
                                Basket items = _con.sales.items.elementAt(index);
                                return Wrap(
                                  children: <Widget>[
                                    LabelAndText(
                                      title: '#${index + 1} ${items.product_name??""}',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    // LabelAndText(
                                    //   title: '${items.serial_no??""}',
                                    //   fontWeight: FontWeight.bold,
                                    // ),
                                    LabelAndText(
                                      title:
                                          '${double.parse(items.quantity).toStringAsFixed(0).toString()} X ${double.parse(items.unit_price).toStringAsFixed(2).toString()}',
                                      salesInfoText:
                                          '${double.parse(items.subtotal).toStringAsFixed(2).toString()}',
                                    ),

                                    SizedBox(
                                      height: 35,
                                    ),
                                    Divider(
                                      thickness: 1,
                                      height: 1,
                                      color: Colors.grey,
                                      indent: 1,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        LabelAndText(
                          title: 'TotalQty'.tr,
                          salesInfoText: '${_con.sales.total_items??""}',
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: Colors.grey,
                          indent: 5,
                        ),
                        LabelAndText(
                          title: 'TotalWithoutVat'.tr,
                          salesInfoText:
                              '${double.parse(_con.sales.total).toStringAsFixed(2).toString()}SAR',
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: Colors.grey,
                          indent: 5,
                        ),
                        LabelAndText(
                          title: 'VAT'.tr,
                          salesInfoText:
                              '${double.parse(_con.sales.total_tax).toStringAsFixed(2).toString()}SAR',
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: Colors.grey,
                          indent: 5,
                        ),
                        LabelAndText(
                          title: 'TotalWithVat'.tr,
                          salesInfoText:
                              '${double.parse(_con.sales.grand_total).toStringAsFixed(2).toString()}SAR',
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: Colors.grey,
                          indent: 5,
                        ),
                        LabelAndText(
                          title: 'GrandTotal'.tr,
                          salesInfoText:
                              '${double.parse(_con.sales.grand_total).toStringAsFixed(2).toString()}SAR',
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: Colors.grey,
                          indent: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                'PaidBy'.tr+': ${_con.sales.paidby ?? ""}',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                'PaidAmount'.tr+': ${double.parse(_con.sales.paid).toStringAsFixed(2).toString() ?? ''}SAR',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                'Change'.tr+': ${_con.sales.payment_term ?? ''}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'StaffNote'.tr+': ${_con.sales.staff_note ?? ''}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              );
          }),
        ),
      ),
    );
  }
}
