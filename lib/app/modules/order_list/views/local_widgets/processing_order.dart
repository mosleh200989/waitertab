import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/modules/order_list/controllers/order_list_controller.dart';
import 'package:waiter/app/routes/app_pages.dart';
class ProcessingOrder  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle labelTextStyle=TextStyle(fontWeight: FontWeight.bold);
    final Widget dividerLabel=  Container( height: 30.0,width: 2.0, color: Colors.grey,);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetX<OrderListController>(
            builder: (_con) {
              if (_con.isLoading.value)
                return Center(child: CircularProgressIndicator());
              else
                return Column(
                  children: [
                    Table(
                      columnWidths: {0:FractionColumnWidth(.2)},
                      border: TableBorder.all(width: 0.0,),
                      defaultVerticalAlignment :TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                            children: [
                              Text('OrderNo'.tr,textAlign: TextAlign.center,),
                              Text('CustomerName'.tr,textAlign: TextAlign.center,),
                              Text('Table'.tr,textAlign: TextAlign.center,),
                              Text('OrderDate'.tr,textAlign: TextAlign.center,),
                              Text('Amount'.tr,textAlign: TextAlign.center,),
                              Text('Action'.tr,textAlign: TextAlign.center,),
                            ]
                        ),
                      ],
                    ),
                    Container(
                        child:Table(
                          columnWidths: {0:FractionColumnWidth(.2)},
                          border: TableBorder.all(width: 0.0,),
                          defaultVerticalAlignment :TableCellVerticalAlignment.middle,
                          // border: TableBorder.all(width:1, color:Colors.black45),
                          children:  _con?.salesListProcessing?.map((salesData){
                            return   TableRow( //return table row in every loop
                                children: [
                                  //table cells inside table row
                                  TableCell(child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child:Text(salesData.id)
                                  )
                                  ),
                                  TableCell(child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child:Text(salesData.customer)
                                  )
                                  ),
                                  TableCell(child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child:Text(salesData.table_no)
                                  )
                                  ),
                                  TableCell(child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child:Text(salesData.date??'')
                                  ),),
                                  TableCell(child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child:Text('${double.parse(salesData.total).toStringAsFixed(2).toString()}')
                                  ),),
                                  TableCell(child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child:Row(
                                        children:<Widget> [
                                          Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,),
                                            onPressed:  () {
                                              Get.reload<OrderListController>();
                                              Get.toNamed(Routes.ORDER_VIEW, arguments: {'reference':salesData.reference_no});
                                            },)),

                                        ],
                                      )
                                  ),),
                                ]
                            );
                          })?.toList()??[],
                        )
                    ),
                  ],
                );
            }
        ),
      ),
    );
  }
}
