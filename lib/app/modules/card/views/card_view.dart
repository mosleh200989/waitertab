import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/basket.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';
import 'package:waiter/app/modules/order_details/controllers/order_details_controller.dart';
import 'package:waiter/app/routes/app_pages.dart';
import '../controllers/card_controller.dart';

class CardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppController appController=Get.find();
    final OrderDetailsController orderDetailsController=Get.find();
    final TextStyle labelTextStyle=TextStyle(fontWeight: FontWeight.normal,);
    return Scaffold(
      appBar: AppBar(
        title: Text('Card'),
        centerTitle: true,
        actions: [
          Container(
            height: 20,
            width: 80,
            child: TextButton(
                onPressed: () {
                  // Get.reload();
                  Get.offNamed(Routes.HOME);
            }, child: Text('Add New Item',textAlign:TextAlign.center,style: TextStyle(color: Colors.white),),
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(10),
              ),
            ),
          )
        ],

      ),
      backgroundColor: Colors.grey.shade200,
      body:GetX<CardController>(
        builder: (controller) {
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
                        children:<Widget>[
                          Expanded(child: Text('Cart Info',style: labelTextStyle,)),
                          Expanded(child: Text('Unit Price',style: labelTextStyle,)),
                          Expanded(child: Text('Quantity',style: labelTextStyle,)),
                          Expanded(child: Text('Total Price',style: labelTextStyle,)),
                          Expanded(child: Text('Action',style: labelTextStyle,textAlign: TextAlign.end,)),
                      ],),
                    ),
                  ),
                  SizedBox(height: 10,),
                 GetX<AppController>(
                   builder: (appController) {
                     return Container(
                       height: 200,
                       child: ListView.builder(
                         reverse: controller.isReverse,
                         itemCount: appController.basketItems.length,
                         itemBuilder: (context, index) {
                         final  String productOption="${appController?.basketItems?.elementAt(index)?.product_option??''}";
                         return  Card(
                           margin: EdgeInsets.all(5),
                           elevation: 0,
                           child: Padding(
                             padding: const EdgeInsets.all(5.0),
                             child: Wrap(
                               children:<Widget> [
                                 Row(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children:<Widget>[
                                     Expanded(child: Text('${appController.basketItems.elementAt(index).product_name} ${productOption!=''?"(":""} ${productOption} ${productOption!=''?")":""}',style: labelTextStyle,)),
                                     Expanded(child: Text('Tk ${appController.basketItems.elementAt(index).real_unit_price??''}',style: labelTextStyle,)),
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
                                                   backgroundColor:Colors.grey,
                                                   child: Icon(Icons.add,color: Colors.black,)),
                                             ),
                                              Expanded(
                                               child: Padding(
                                                 padding: const EdgeInsets.all(5.0),
                                                 child: Text('${appController.basketItems.elementAt(index).quantity}',textAlign: TextAlign.center,),
                                               ),
                                             ),
                                             InkWell(
                                               onTap: () {
                                                 controller.decrement(index);
                                               },
                                               child: CircleAvatar(
                                                   radius: 12,
                                                   backgroundColor:Colors.grey,
                                                   child: Icon(Icons.remove,color: Colors.black,)),
                                             ),

                                           ],
                                         ),);
                                       }
                                     ),
                                     GetBuilder<CardController>(
                                       builder: (_) {
                                         return Expanded(child: Text('Tk ${appController.basketItems.elementAt(index).net_price??''}',style: labelTextStyle,textAlign: TextAlign.center,));
                                       }
                                     ),
                                     Expanded(child: IconButton(
                                       icon:Align(
                                        alignment :Alignment.topRight,
                                           child: Icon(Icons.delete,color: Colors.red.shade500,)),
                                       onPressed:() =>  controller.removeSingleOrder(index)
                                     ,))
                                   ],),
                                 Container(
                                   height: 30,
                                   child: TextButton.icon(
                                       style: TextButton.styleFrom(
                                         shape:StadiumBorder(),
                                       ),
                                       onPressed: () {
                                         controller.changeShowNoteField(true,index);
                                       },
                                       icon: Icon(Icons.arrow_drop_down,),
                                       label: Text('Notes',style: labelTextStyle,)),
                                 ),
                                      GetBuilder<CardController>(
                                        builder: (_) {
                                          return Visibility(
                                               visible:_.appController.basketItems[index].isNotes==true,
                                               child: TextFormField(
                                                 controller: appController.basketItems[index].textEditContNotes,
                                                 keyboardType: TextInputType.text,
                                                /* controller: TextEditingController.fromValue(
                                                     TextEditingValue(
                                                         text: appController.basketItems[index].product_name??'',
                                                         selection: new TextSelection.collapsed(
                                                             offset: appController.basketItems.length),
                                                     )),*/

                                                 onChanged: (value) {
                                                   controller.addNotes(index,value);
                                                   // controller.textEditNoteList[index].text=value;
                                                 },
                                                 decoration: InputDecoration(
                                                   contentPadding: EdgeInsets.all(12),
                                                   hintText: 'Notes'.tr,
                                                   hintStyle: TextStyle(
                                                       color: Get.theme
                                                           .focusColor
                                                           .withOpacity(0.7)),
                                                   border: OutlineInputBorder(
                                                       borderSide: BorderSide(
                                                           color:Get.theme
                                                               .focusColor
                                                               .withOpacity(0.2))),
                                                   focusedBorder: OutlineInputBorder(
                                                       borderSide: BorderSide(
                                                           color:Get.theme
                                                               .focusColor
                                                               .withOpacity(0.5))),
                                                   enabledBorder: OutlineInputBorder(
                                                       borderSide: BorderSide(
                                                           color: Get.theme
                                                               .focusColor
                                                               .withOpacity(0.2))),

                                                 ),
                                               ),



                                 );
                                        }
                                      ),

                               ],
                             ),
                           ),
                         );
                       },),
                     );
                   }
                 ),
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

                 GetBuilder<CardController>(
                 init: controller,
                  builder: (_cont) {
                    return  Wrap(
                      children: [
                        Card(
                          child: Container(
                            height: 40,
                            color: _cont.isDineIn==true?Colors.grey:null,
                            child: TextButton(
                                onPressed: () {
                              _cont.changeOrderMethod(true);
                            }, child: Text('Dine In',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.normal),)),
                          ),
                        ),
                        Card(
                          child: Container(
                            height: 40,
                            color:_cont.isParcel==true?Colors.grey:null,
                            child: TextButton(
                                onPressed: () {
                              _cont.changeOrderMethod(false);
                            }, child: Text('Parcel',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.normal),)),
                          ),
                        ),
                        Visibility(
                        visible:_cont.isDineIn==true,
                          child: Container(
                    height: 85,
                    child:  ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
              return  GestureDetector(
                onTap: () {
                  _cont.selectedItem(index);
                },
                child: Card(
                  elevation: 1,
                  color: _cont.selectedIndex == index ? Colors.grey.shade500 : null,
                  child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 40,
                            width: 60,
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.account_balance),
                                SizedBox(height: 10,),
                                Expanded(child: Text('Table No: $index',textAlign: TextAlign.center,))
                              ],
                            ),
                          ),
                  ),
                ),
              ) ;
            },),
    ),
                        ),
                      ],
                    );
  }
),

                  Card(
                    elevation: 0.0,
                   child:TextFormField(
                     controller: controller.orderNoteController,
                     keyboardType: TextInputType.text,
                     decoration: InputDecoration(
                       contentPadding: EdgeInsets.all(12),
                       hintText: 'Order Notes'.tr,
                       hintStyle: TextStyle(
                           color: Get.theme
                               .focusColor
                               .withOpacity(0.7)),
                       border: OutlineInputBorder(
                           borderSide: BorderSide(
                               color:Get.theme
                                   .focusColor
                                   .withOpacity(0.2))),
                       focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(
                               color:Get.theme
                                   .focusColor
                                   .withOpacity(0.5))),
                       enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(
                               color: Get.theme
                                   .focusColor
                                   .withOpacity(0.2))),

                     ),
                   ),
                  ),

                  GetX<CardController>(
                    builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children:<Widget> [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:<Widget> [
                                Text('Customer Name'),
                                Card(
                                  elevation: 1,
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
                                Text('Discount'),
                                Card(
                                  elevation: 0.0,
                                  child: Container(
                                      width: Get.width *.5,
                                      height: 45.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 7.0,bottom: 7.0),
                                        child: TextFormField(
                                          controller: controller.discountTextController,
                                          keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                                         inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),],
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(12),
                                            hintText: 'Discount',
                                            hintStyle: TextStyle(
                                                color: Get.theme
                                                    .focusColor
                                                    .withOpacity(0.7)),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:Get.theme
                                                        .focusColor
                                                        .withOpacity(0.2))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:Get.theme
                                                        .focusColor
                                                        .withOpacity(0.0))),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Get.theme
                                                        .focusColor
                                                        .withOpacity(0.2))),

                                          ),
                                        ),
                                      )),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:<Widget> [
                                Text('Shipping Cost'),
                                Card(
                                  elevation: 0.0,
                                  child: Container(
                                      width: Get.width *.5,
                                      height: 45,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 7.0,bottom: 7.0),
                                        child: TextFormField(
                                          controller: controller.shippingTextController,
                                          keyboardType: TextInputType.number,
                                         inputFormatters:  <TextInputFormatter>[
                                           FilteringTextInputFormatter.digitsOnly
                                         ],
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(12),
                                            hintText: 'shipping cost',
                                            hintStyle: TextStyle(
                                                color: Get.theme
                                                    .focusColor
                                                    .withOpacity(0.7)),
                                            // border: OutlineInputBorder(
                                            //     borderSide: BorderSide(
                                            //         color:Get.theme
                                            //             .focusColor
                                            //             .withOpacity(0.2))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:Get.theme
                                                        .focusColor
                                                        .withOpacity(0.0))),
                                            // enabledBorder: OutlineInputBorder(
                                            //     borderSide: BorderSide(
                                            //         color: Get.theme
                                            //             .focusColor
                                            //             .withOpacity(0.2))),

                                          ),
                                        ),
                                      )),
                                )
                              ],
                            ),
                    /*        Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:<Widget> [
                                Text('Vat/Tax'),
                                Card(
                                  elevation: 1,
                                  child: Container(
                                      width: Get.width *.5,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 7.0,bottom: 7.0),
                                        child: Text('Tk 15',textAlign: TextAlign.center,),
                                      )),
                                )
                              ],
                            ),*/
                          /*  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:<Widget> [
                                Text('Service Charge'),
                                Card(
                                  elevation: 1,
                                  child: Container(
                                      width: Get.width *.5,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 7.0,bottom: 7.0),
                                        child: Text('Tk 15',textAlign: TextAlign.center,),
                                      )),
                                )
                              ],
                            ),*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:<Widget> [
                                Text('Grand Total'),
                                Card(
                                  elevation: 1,
                                  child: Container(
                                      width: Get.width *.5,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 7.0,bottom: 7.0),
                                        child: Text('Tk ${_.grandTotal??0.0}',textAlign: TextAlign.center,),
                                      )),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Card(
                                  child: Container(
                                    height: 40,
                                    color: _.isCash==true?Colors.grey:null,
                                    child: TextButton(
                                        onPressed: () {
                                          _.changePaymentMethod(true);
                                        }, child: Text('Cash',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.normal),)),
                                  ),
                                ),
                                Card(
                                  child: Container(
                                    height: 40,
                                    color: _.isCC==true?Colors.grey:null,
                                    child: TextButton(
                                        onPressed: () {
                                          _.changePaymentMethod(false);
                                        }, child: Text('CC',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.normal),)),
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: _.isCC==true,
                              child: Padding(
                                padding: const EdgeInsets.only(left:60,right: 60),
                                child: Row(
                                  children: <Widget>[
                                    Card(
                                      child: Container(
                                        height: 40,
                                        color: _.isMada==true?Colors.grey:null,
                                        child: TextButton(
                                            onPressed: () {
                                              _.changeCCMethod(true);
                                            }, child: Text('Mada',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.normal),)),
                                      ),
                                    ),
                                    Card(
                                      child: Container(
                                        height: 40,
                                        color: _.isVisa==true?Colors.grey:null,
                                        child: TextButton(
                                            onPressed: () {
                                              _.changeCCMethod(false);
                                            }, child: Text('Visa',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.normal),)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )

                          ],
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          );
        }
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Expanded(
                 child: ElevatedButton(onPressed: () { 

                  }, child: Text('Cancel'),
                 style: ElevatedButton.styleFrom(
                   primary: Colors.red

                 ),),
               ),
                SizedBox(width: 10,),
                Expanded(
                  child: ElevatedButton(onPressed: () {
                    Get.find<CardController>().postSalesOrder();
                  }, child: Text('Place Order'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green
                  ),),
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
}
