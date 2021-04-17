import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/routes/app_pages.dart';
import '../controllers/card_controller.dart';

class CardView extends GetView<CardController> {
  @override
  Widget build(BuildContext context) {
    final TextStyle labelTextStyle=TextStyle(fontWeight: FontWeight.bold);
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
      body:SingleChildScrollView(
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
                    Expanded(child: Text('Cart Info',style: labelTextStyle,)),
                    Expanded(child: Text('Size',style: labelTextStyle,)),
                      Expanded(child: Text('Unit Price',style: labelTextStyle,)),
                      Expanded(child: Text('Quantity',style: labelTextStyle,)),
                      Expanded(child: Text('Total Price',style: labelTextStyle,)),
                  ],),
                ),
              ),
              SizedBox(height: 10,),
             Container(
               height: 200,
               child: ListView.builder(
                 itemCount: 3,
                 itemBuilder: (context, index) {
                 return  Card(
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
                                 controller.changeShowNoteField(true);

                               },
                               icon: Icon(Icons.arrow_drop_down,),
                               label: Text('Notes')),
                         ),
                         Obx(()=> Visibility(
                           visible: controller.showNote.value==true,
                           child:  TextFormField(
                             controller: controller.noteController,
                             keyboardType: TextInputType.text,
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
                         ),
                         ),
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
                      Icon(Icons.account_balance),
                      SizedBox(width: 50,),
                      Text('Select Table')
                    ],
                  ),
                ),
              ),
             GetBuilder<CardController>(
 init: controller,
  builder: (_cont) {
    return  Container(
        height: 100,
        child:  ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
          return  GestureDetector(
            onTap: () {
              _cont.selectedItem(index);
            },
            child: Card(
              elevation: 5,
              color: _cont.selectedIndex == index ? Colors.grey.shade500 : null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 70,
                  width: 60,

                  child: Column(
                    children: <Widget>[
                      Icon(Icons.account_balance),
                      SizedBox(height: 20,),
                      Expanded(child: Text('Table No: $index',textAlign: TextAlign.center,))
                    ],
                  ),
                ),
              ),
            ),
          ) ;
        },),
    );
  }
),

              Card(
                elevation: 5.0,
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
