import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CancelOrder  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle labelTextStyle=TextStyle(fontWeight: FontWeight.bold);
    final Widget dividerLabel=  Container( height: 30.0,width: 2.0, color: Colors.grey,);
    return Wrap(
      children:<Widget> [
        Card(
          margin: EdgeInsets.all(5),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget>[
                Expanded(child: Text('Order No.',textAlign: TextAlign.center,style: labelTextStyle,)),
                dividerLabel,
                Expanded(child: Text('Customer Name',textAlign: TextAlign.center,style: labelTextStyle,)),
                dividerLabel,
                Expanded(child: Text('Table',textAlign: TextAlign.center,style: labelTextStyle,)),
                dividerLabel,
                Expanded(child: Text('Order Date',textAlign: TextAlign.center,style: labelTextStyle,)),
                dividerLabel,
                Expanded(child: Text('Amount',textAlign: TextAlign.center,style: labelTextStyle,)),
                dividerLabel,
                Expanded(child: Text('Action',textAlign: TextAlign.center,style: labelTextStyle,)),
              ],),
          ),
        ),
        Container(
          height: 300,
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return  Card(
                margin: EdgeInsets.all(5),
                elevation: 5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget>[
                    Expanded(child: Text('635',textAlign: TextAlign.center,style: labelTextStyle,)),
                    dividerLabel,
                    Expanded(child: Text('Mostafiz',textAlign: TextAlign.center,style: labelTextStyle,)),
                    dividerLabel,
                    Expanded(child: Text('5',textAlign: TextAlign.center,style: labelTextStyle,)),
                    dividerLabel,
                    Expanded(child: Text('2021-03-10',textAlign: TextAlign.center,style: labelTextStyle,)),
                    dividerLabel,
                    Expanded(child: Text('Tk. 1.00',textAlign: TextAlign.center,style: labelTextStyle,)),
                    dividerLabel,
                    Expanded(child:IconButton(icon:Icon(Icons.visibility,color: Colors.red,), onPressed: null)),
                  ],),
              );
            },),
        )
      ],
    );
  }
}

