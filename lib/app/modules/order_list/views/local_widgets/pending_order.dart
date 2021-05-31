import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/modules/order_list/controllers/order_list_controller.dart';
import 'package:waiter/app/routes/app_pages.dart';
class PendingOrder  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrderListController controller=Get.find();
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
                          Text('Order No.',textAlign: TextAlign.center,),
                          Text('Customer Name',textAlign: TextAlign.center,),
                          Text('Table',textAlign: TextAlign.center,),
                          Text('Order Date',textAlign: TextAlign.center,),
                          Text('Amount',textAlign: TextAlign.center,),
                          Text('Action',textAlign: TextAlign.center,),
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
                      children: _con.salesList.map((salesData){
                        return TableRow( //return table row in every loop
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
                                      Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed:() {
                                        Get.toNamed(Routes.CARD);
                                      },))
                                    ],
                                  )
                              ),),
                            ]
                        );
                      }).toList(),
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
