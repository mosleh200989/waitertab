import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/routes/app_pages.dart';
class PendingOrder  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Table(
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
              TableRow( children: [
                Column(children:[Text('420')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed:  () {
                    Get.toNamed(Routes.ORDER_VIEW);
                  },)),
                  Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed:() {
                    Get.toNamed(Routes.CARD);
                  },))
                ],)]),
              ]),
              TableRow( children: [
                Column(children:[Text('420')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed: null)),
                    Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed: null))
                  ],)]),
              ]),
              TableRow( children: [
                Column(children:[Text('420')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed: null)),
                    Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed: null))
                  ],)]),
              ]),
              TableRow( children: [
                Column(children:[Text('420')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed: null)),
                    Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed: null))
                  ],)]),
              ]),
              TableRow( children: [
                Column(children:[Text('420')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed: null)),
                    Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed: null))
                  ],)]),
              ]),
              TableRow( children: [
                Column(children:[Text('420')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed: null)),
                    Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed: null))
                  ],)]),
              ]),
              TableRow( children: [
                Column(children:[Text('420')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed: null)),
                    Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed: null))
                  ],)]),
              ]),
              TableRow( children: [
                Column(children:[Text('420')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed: null)),
                    Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed: null))
                  ],)]),
              ]),
              TableRow( children: [
                Column(children:[Text('420')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed: null)),
                    Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed: null))
                  ],)]),
              ]),
              TableRow( children: [
                Column(children:[Text('420')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed: null)),
                    Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed: null))
                  ],)]),
              ]),
              TableRow( children: [
                Column(children:[Text('420')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed: null)),
                    Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed: null))
                  ],)]),
              ]),
              TableRow( children: [
                Column(children:[Text('420')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed: null)),
                    Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed: null))
                  ],)]),
              ]),
              TableRow( children: [
                Column(children:[Text('420')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed: null)),
                    Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed: null))
                  ],)]),
              ]),
              TableRow( children: [
                Column(children:[Text('420')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed: null)),
                    Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed: null))
                  ],)]),
              ]),
              TableRow( children: [
                Column(children:[Text('420')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed: null)),
                    Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed: null))
                  ],)]),
              ]),
              TableRow( children: [
                Column(children:[Text('420')]),
                Column(children:[Text('Flutter')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Text('5*')]),
                Column(children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed: null)),
                    Expanded(child: IconButton(icon:Icon(Icons.edit), onPressed: null))
                  ],)]),
              ]),








            ],
          ),
        ),
      ),
    );
  }
}
