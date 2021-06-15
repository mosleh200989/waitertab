import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waiter/app/global_widgets/EmptyOrdersWidget.dart';

import '../controllers/tasks_details_controller.dart';

class TaskDetailsView extends GetView<TasksDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TasksDetails'.tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GetX<TasksDetailsController>(
          builder: (_con) {
            if (_con.isLoading.value)
              return LinearProgressIndicator();
            else
            return Visibility(
              visible: _con.tasks !=null,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name'.tr, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold), ),
                    Text('${_con?.tasks?.name??""}', style: TextStyle(fontSize: 16), ),
                  _con.paddingDividerWidget,
                    Text('Description'.tr, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold), ),
                    Text('${_con?.tasks?.description??""}', style: TextStyle(fontSize: 16), ),
                    _con.paddingDividerWidget,
                    Text('CreateDate'.tr, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold), ),
                    Text('${_con?.tasks?.dateadded??""}', style: TextStyle(fontSize: 16), ),
                    _con.paddingDividerWidget,
                    Text('StartDate'.tr, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold), ),
                    Text('${_con?.tasks?.startdate??""}', style: TextStyle(fontSize: 16), ),
                    _con.paddingDividerWidget,
                    Text('DueDate'.tr, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold), ),
                    Text('${_con?.tasks?.duedate??""}', style: TextStyle(fontSize: 16), ),
                    _con.paddingDividerWidget,
                    Text('ChecklistItem'.tr, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold), ),
                    Container(
                      child:_con?.tasks?.checklist_items?.length ==null? Container(height: 10,width: 10,): ListView.builder(
                        itemCount: _con?.tasks?.checklist_items?.length??0,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                        return ListTile(
                          leading: Checkbox(
                            checkColor: Colors.lightGreen,
                            value: _con.tasks.checklist_items.elementAt(index).finished=='0'?false:true,
                            focusColor: Colors.lightGreen,
                            onChanged: (value) {
                              _con.changedCheckList(value,_con.tasks.id, _con.tasks.checklist_items.elementAt(index));
                            },
                          ) ,
                            title:  Text('${_con.tasks.checklist_items.elementAt(index).description}'),);
                      },),
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
