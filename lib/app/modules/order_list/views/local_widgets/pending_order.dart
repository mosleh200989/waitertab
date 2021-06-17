import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:waiter/app/data/models/sales.dart';
import 'package:waiter/app/global_widgets/EmptyOrdersWidget.dart';
import 'package:waiter/app/modules/order_list/controllers/order_list_controller.dart';
import 'package:waiter/app/routes/app_pages.dart';
class PendingOrder  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrderListController _con = Get.find<OrderListController>();
    return  Wrap(
      children: [
        Obx(() {
      //     if (_con.isLoading.value)
      //   return Center(child: CircularProgressIndicator());
      // else
          return Column(
            children: [
              Container(
                  height: Get.height - 140,
                  child: _con.salesList.isEmpty
                      ? EmptyOrdersWidget()
                      : RefreshIndicator(
                    onRefresh: _con.refreshPendingList,
                    child: ListView.builder(
                      controller: _con.scrollController,
                      itemCount: _con.salesList.length,
                      // shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        Sales salesData = _con.salesList[index];
                        if (index == _con.salesList.length - 1 &&
                            _con.isMoreDataAvailable.value == true) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Container(
                          margin: EdgeInsets.only(bottom: 2.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text('${salesData.id ?? ''}',
                                              textAlign: TextAlign.center)
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text('${salesData.customer ?? ''}',
                                              textAlign: TextAlign.center)
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text('${salesData?.tableModel?.name ?? ''}',
                                              textAlign: TextAlign.center)
                                      )),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text('${salesData.date ?? ''}',
                                            textAlign: TextAlign.center)
                                    ),),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text('${double.parse(salesData.total)
                                            .toStringAsFixed(2)
                                            .toString() ?? ""}',
                                            textAlign: TextAlign.center)
                                    ),), Expanded(
                                    flex: 2,
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(child: IconButton(icon: Icon(
                                              Icons.visibility, color: Colors.red,),
                                              onPressed: () {
                                                Get.reload<OrderListController>();
                                                Get.toNamed(Routes.ORDER_VIEW,
                                                    arguments: {'reference': salesData.id,'orderStatus':salesData.order_status
                                                    });
                                              },)),

                                          ],
                                        )
                                    ),),


                                ],
                              ),
                              Divider(thickness: 2,
                                indent: 2,
                                endIndent: 2,
                                color: Colors.grey,
                                height: 5,)
                            ],
                          ),
                        );
                      },),
                  ),
                ),

            ],
          );


    }
                ),
      ],
    );


  }
}
