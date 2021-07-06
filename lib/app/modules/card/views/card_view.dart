import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/basket.dart';
import 'package:waiter/app/data/models/options.dart';
import 'package:waiter/app/data/models/table.dart';
import 'package:waiter/app/global_widgets/EmptyOrdersWidget.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';
import 'package:waiter/app/modules/home/controllers/home_controller.dart';
import 'package:waiter/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:waiter/app/modules/product_list/controllers/product_list_controller.dart';
import 'package:waiter/app/routes/app_pages.dart';
import '../controllers/card_controller.dart';

class CardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.find();
    final ProductListController orderDetailsController = Get.find();
    final CardController cardController = Get.find();
    final TextStyle labelTextStyle = TextStyle(
      fontWeight: FontWeight.normal,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Card'.tr),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Get.find<NotificationsController>().refreshNotificationList();
              Get.toNamed(Routes.NOTIFICATIONS);
              // Get.offNamed(Routes.NOTIFICATION_PAGE, arguments: 0);
            },
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Icon(
                  Icons.notification_important_rounded,
                  color: Colors.white,
                  size: 24,
                ),
                Obx(() {
                return Container(
                  child:  Text('${Get.find<AuthController>().inReadCount}',
                    textAlign: TextAlign.center,
                    style: Get.theme.textTheme.caption.merge   (
                      TextStyle(color: Colors.black, fontSize: 12,fontWeight: FontWeight.normal),
                    ),
                  ),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(color: Colors.blueGrey.shade200, borderRadius: BorderRadius.all(Radius.circular(10))),
                  constraints: BoxConstraints(minWidth: 15, maxWidth: 80, minHeight: 15, maxHeight: 50),
                );
}),
              ],
            ),
            // color: Colors.transparent,
          ),
          TextButton(
            onPressed: () {
              if(Get.currentRoute==Routes.CARD){
                // Get.delete<ProductListController>();
                Get.reload<HomeController>(force: true);
                Get.offAllNamed(Routes.HOME);
              }
            },
            child:Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 24,
                ),

            // color: Colors.transparent,
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade200,
      body: GetX<CardController>(builder: (controller) {
        return SingleChildScrollView(
          reverse: controller.isReverse,
          child: SafeArea(
            child: Wrap(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.all(5),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          'CartInfo'.tr,
                          style: labelTextStyle,
                        )),
                        Expanded(
                            child: Text(
                          'UnitPrice'.tr,
                          style: labelTextStyle,
                        )),
                        Expanded(
                            child: Text(
                          'Quantity'.tr,
                          style: labelTextStyle,
                        )),
                        Expanded(
                            child: Text(
                          'TotalPrice'.tr,
                          style: labelTextStyle,
                        )),
                        Expanded(
                            child: Text(
                          'Action'.tr,
                          style: labelTextStyle,
                          textAlign: TextAlign.end,
                        )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GetX<AppController>(builder: (appController) {
                  return Container(
                    height: Get.height * .30,
                    child: ListView.builder(
                      // reverse: controller.isReverse,
                      itemCount: appController.basketItems.length,
                      itemBuilder: (context, index) {
                        final String productOption =
                            "${appController?.basketItems?.elementAt(index)?.optionValue ?? ''}";
                        appController.textEditNoteController.add(TextEditingController());
                        return Card(
                          margin: EdgeInsets.all(5),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Wrap(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      '${appController.basketItems.elementAt(index).product_name} ${productOption != '' ? "(" : ""} ${productOption} ${productOption != '' ? ")" : ""}',
                                      style: labelTextStyle,
                                    )),
                                    Expanded(
                                        child: Text(
                                      '${appController.basketItems.elementAt(index).real_unit_price ?? ''}SAR',
                                      style: labelTextStyle,
                                    )),
                                    GetBuilder<CardController>(
                                        builder: (controller) {
                                      return Expanded(
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller.increment(index);
                                              },
                                              child: CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor: Colors.grey,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  )),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  '${appController.basketItems.elementAt(index).quantity}',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                controller.decrement(index);
                                              },
                                              child: CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor: Colors.grey,
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.black,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                    GetBuilder<CardController>(builder: (_) {
                                      return Expanded(
                                          child: Text(
                                        '${appController.basketItems.elementAt(index).subtotal ?? ''}SAR',
                                        style: labelTextStyle,
                                        textAlign: TextAlign.center,
                                      ));
                                    }),
                                    Expanded(
                                        child: IconButton(
                                      icon: Align(
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red.shade500,
                                          )),
                                      onPressed: () =>
                                          controller.removeSingleOrder(index),
                                    ))
                                  ],
                                ),
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 35,
                                      child: TextButton.icon(
                                          style: TextButton.styleFrom(
                                            shape: StadiumBorder(),
                                            primary: Colors.black
                                          ),
                                          onPressed: () {
                                            controller.changeShowNoteField(
                                                true, index);
                                          },
                                          icon: Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                          label: Text(
                                            'Notes'.tr,
                                            style: labelTextStyle,
                                          )),
                                    ),
                                    Visibility(
                                      visible: appController.basketItems.elementAt(index).product_option !=null,
                                      child: ElevatedButton(onPressed: () {
                                        controller.getOptionList(appController.basketItems.elementAt(index).product_id);
                                        _showSubmittedDialog(controller,appController.basketItems.elementAt(index),index);

                                      }, child: Text('Edit'.tr),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blueGrey.shade400,
                                        fixedSize: Size(130, 20)
                                      ),),
                                    )
                                  ],
                                ),
                                GetBuilder<CardController>(builder: (_) {
                                  return Visibility(
                                    visible: _.appController.basketItems[index]
                                            .isNotes ==
                                        true,
                                    child: singleItemText(index, _.appController.textEditNoteController[index]),
                                  );
                                }),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
                /*Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.account_balance),
                          SizedBox(width: 50,),
                          Text('Select Table')
                        ],
                      ),
                    ),
                  ),*/

                 Row(
                   children: [
                     Expanded(
                       child: Divider(
                         thickness:1,
                         endIndent: 5,
                         indent: 5,
                         height: 2,
                         color: Colors.black,
                       ),
                     )
                   ],
                 ),
                GetBuilder<CardController>(
                    init: controller,
                    builder: (_cont) {
                      return Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        _cont.changeOrderMethod(true);
                                      },
                                      style:ElevatedButton.styleFrom(
                                        primary:  _cont.isDineIn == true
                                            ? Colors.blueGrey
                                            : Colors.white

                                      ),
                                      child: Text(
                                        'DineIn'.tr,
                                        style: TextStyle(
                                            color:_cont.isDineIn == true?Colors.white: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18),
                                      )),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        _cont.changeOrderMethod(false);
                                      },
                                      style:ElevatedButton.styleFrom(
                                          primary:_cont.isParcel == true
                                              ? Colors.blueGrey
                                              :  Colors.white

                                      ),
                                      child: Text(
                                        'Parcel'.tr,
                                        style: TextStyle(
                                            color: _cont.isParcel == true?Colors.white:Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _cont.isDineIn == true,
                            child: Container(
                              height: 120,
                              child: controller.tableList.isEmpty?EmptyOrdersWidget(): ListView.builder(
                                itemCount: controller.tableList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                final  TableModel tableModel=controller.tableList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      _cont.selectedItem(index);
                                    },
                                    child: Card(
                                      elevation: 1,
                                      color: _cont.selectedIndex == index
                                          ? Colors.blueGrey
                                          : null,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          children: <Widget>[
                                           Expanded(
                                             flex:5,
                                               child: Image.asset('assets/images/res_table.jpg')) ,
                                            // Expanded(
                                            //     child: Text(
                                            //   'TableNo'.tr + ': ${tableModel.id??''}',
                                            //   textAlign: TextAlign.center,style: TextStyle(color: _cont.selectedIndex == index?Colors.white:Colors.black),
                                            // )),
                                            Expanded(
                                                flex:2,
                                                child: Text(
                                              '${tableModel.name??''}',
                                              textAlign: TextAlign.center,style: TextStyle(color: _cont.selectedIndex == index?Colors.white:Colors.black),
                                            )),
                                            Expanded(
                                                flex:2,
                                                child: Text(
                                                  'Capacity'.tr + ': ${tableModel.capacity??''}',
                                                  textAlign: TextAlign.center,style: TextStyle(color: _cont.selectedIndex == index?Colors.white:Colors.black),
                                                )),
                                            // Expanded(
                                            //     child: Text(
                                            //       'floor'.tr + ': ${tableModel.floor??''}',
                                            //       textAlign: TextAlign.center,style: TextStyle(color: _cont.selectedIndex == index?Colors.white:Colors.black),
                                            //     ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                Card(
                  elevation: 0.0,
                  child: TextFormField(
                    controller: controller.orderNoteController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'OrderNotes'.tr,
                      hintStyle: TextStyle(
                          color: Get.theme.focusColor.withOpacity(0.7)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Get.theme.focusColor.withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Get.theme.focusColor.withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Get.theme.focusColor.withOpacity(0.2))),
                    ),
                  ),
                ),
                GetX<CardController>(builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('GrandTotal'.tr),
                            Card(
                              elevation: 1,
                              child: Container(
                                  width: Get.width * .5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 7.0, bottom: 7.0),
                                    child: Text(
                                      '${_.grandTotal ?? 0.0} SAR',
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25,right: 25),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      _.changePaymentMethod(true);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary:_.isCash == true? Colors.blueGrey:Colors.white
                                    ),
                                    child: Text(
                                      'Cash'.tr,
                                      style: TextStyle(
                                          color:_.isCash == true? Colors.white:Colors.black,
                                          fontWeight: FontWeight.normal,fontSize: 18),
                                    )),
                              ),
                              SizedBox(width: 25,),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  color: _.isCC == true ? Colors.blueGrey : null,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        _.changePaymentMethod(false);
                                      },
                                      style:ElevatedButton.styleFrom(
                                        primary: _.isCC == true?Colors.blueGrey:Colors.white
                                      ),
                                      child: Text(
                                        'CC'.tr,
                                        style: TextStyle(
                                            color: _.isCC == true?Colors.white:Colors.black87,
                                            fontWeight: FontWeight.normal,fontSize: 18),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: _.isCC == true,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        _.changeCCMethod(true);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary:  _.isMada == true ? Colors.blueGrey:Colors.white
                                      ),
                                      child: Text(
                                        'Mada'.tr,
                                        style: TextStyle(
                                            color:  _.isMada == true ?Colors.white:Colors.black87,
                                            fontWeight: FontWeight.normal),
                                      )),
                                ),
                                SizedBox(width: 20,),
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        _.changeCCMethod(false);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary:   _.isVisa == true ? Colors.blueGrey:Colors.white
                                      ),
                                      child: Text(
                                        'Visa'.tr,
                                        style: TextStyle(
                                            color:  _.isVisa == true ?Colors.white:Colors.black87,
                                            fontWeight: FontWeight.normal),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: GestureDetector(
        child: Container(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.find<CardController>().removeAllList();
                    },
                    child: Text('Cancel'.tr),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.find<CardController>().postSalesOrder();
                    },
                    child: Text('PlaceOrder'.tr),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          // Get.toNamed(Routes.CARD);
        },
      ),
    );
  }
  Widget _showSubmittedDialog(CardController controller,Basket basket,int index){
    Get.defaultDialog(
      title: 'UpdateOrCopy'.tr,
      titleStyle: TextStyle(fontSize: 24),
      backgroundColor: Colors.grey.shade100,
      // barrierDismissible: false,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex:2,
                  child: Obx(()=>
                      DropdownButton<OptionModel>(
                        isExpanded: true,
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                        ),
                        hint:_showOptionText(basket,controller),
                        items:controller?.product?.optionsList?.length  !=null ? controller?.product?.optionsList?.map((lang) {
                          return  DropdownMenuItem<OptionModel>(
                            child: Text(lang?.name??''),
                            value:lang,
                          );
                        })?.toList() : null,
                        // value:controller.optionValue??null,
                        onChanged: (OptionModel option) {
                          print(option.id);
                          controller.changeOption(option);
                        },
                      ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
      confirm: Row(
        children:<Widget> [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  controller.updateOption(index,basket);
            }, child: Text('Update'.tr),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey.shade400,
                  fixedSize: Size(100, 20)
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  controller.newAddItem(basket);
                }, child: Text('Copy'.tr),
            style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey.shade400,
                fixedSize: Size(100, 20)

            ),),
          ),
        ],
      ),
      buttonColor:Colors.grey ,
    );
  }
  Widget _showOptionText(Basket basket,CardController controller) {
    if (controller.optionName != '') {
      return Text('${controller.optionName}');
    } else if(basket.optionValue!=null) {
      return Text('${basket.optionValue}');
    } else {
      return Text("");
    }
  }
  Widget singleItemText(int index, TextEditingController controllertxt) {
    final cardController=Get.find<CardController>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child:TextFormField(
        controller:controllertxt,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          print(value);
          cardController.addNotes(index, value);
          // controller.textEditNoteList[index].text=value;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12),
          hintText: 'Notes'.tr,
          hintStyle: TextStyle(
              color: Get.theme.focusColor
                  .withOpacity(0.7)),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Get.theme.focusColor
                      .withOpacity(0.2))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Get.theme.focusColor
                      .withOpacity(0.5))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Get.theme.focusColor
                      .withOpacity(0.2))),
        ),
      ),
    );
  }
}
