import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/Task.dart';
import 'package:waiter/app/modules/tasks/controllers/tasks_controller.dart';
import 'package:waiter/app/routes/app_pages.dart';

class PendingTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetX<TasksController>(
        builder: (_con) {
          return RefreshIndicator(
            onRefresh: () {
              // print('work done');
            },
            child: ListView.builder(
             itemCount:_con.taskListPending.length ,
              itemBuilder: (context, index) {

               Task task=_con.taskListPending[index];
               if(task.status=='1'){
                 task.statusValue='Not Started';
               }else if(task.status=='2'){
                 task.statusValue='Awaiting Feedback';
               }else if(task.status=='3'){
                 task.statusValue='Testing';
               }else if(task.status=='4'){
                 task.statusValue='In Progress';
               }else{
                 task.statusValue='Complete';
               }
               if(task.priority=='1'){
                 _con.priorityData='task_priority_low'.tr;
               }else if(task.priority=='2'){
                 _con.priorityData='task_priority_medium'.tr;
               }else if(task.priority=='3'){
                 _con.priorityData='task_priority_high'.tr;
               }else if(task.priority=='4'){
                 _con.priorityData='task_priority_urgent'.tr;
               }

               return   Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex:2,
                          child: Text('${task.name}',textAlign: TextAlign.center,)),
                      Expanded(
                          flex:2,
                          child: Text('${_con.priorityData}',textAlign: TextAlign.center)),
                      Expanded(
                          flex:2,
                              child: Column(
                                children: [
                                  // Text('${_con.statusData}'),
                                  ElevatedButton(
                                    onPressed: () {
                                      showStatusDailog(task,index);
                                  },
                                    child: Text('${task.statusValue??''}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blueGrey
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                   Get.toNamed(Routes.TASK_DETAILS);
                                    },
                                    child: Text('View'.tr,style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blueGrey,
                                      fixedSize: Size(100.0, 0.0)
                                    ),
                                  ),

                                ],
                              ),
                           ),
                    ],
                  ),);
              },
            ),
          );
        }
      ),
    );
  }
  Widget showStatusDailog(Task task,int index){
    final taskController=Get.find<TasksController>();
    Get.defaultDialog(
      title: 'ChangeStatus'.tr,
      titleStyle: TextStyle(fontSize: 24,),
      // backgroundColor: Colors.blueGrey,
      // barrierDismissible: false,
      content: SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                DropdownButton<String>(
                                        hint:  Text('${task.statusValue??''}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                        isExpanded:true,
                                        underline: Container(),
                                        items: <String>[
                                           'Not Started',
                                          'Awaiting Feedback',
                                          'Testing',
                                          'In Progress'
                                        ].map((String value) {
                                          return  DropdownMenuItem<String>(
                                            value: value,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(fontWeight: FontWeight.w300,),textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Divider(thickness: 1,indent: 1,endIndent: 2,height: 5,color: Colors.black,),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String value) {
                                          taskController.changeStatus(value,index);
                                          // setState(() {
                                          //   _chosenValue = value;
                                          // });

                  }
                )
            ],
          ),
        ),
      ),
      // textCancel: 'dismiss'.tr,
      // cancelTextColor:Colors.white,
      // onCancel: () {
      // },
      textConfirm: 'Update'.tr,
      confirmTextColor:Colors.white,
      onConfirm: () {
        // controller.addToBasketAndBuyClickEvent(index);
      },

      buttonColor:Colors.grey ,
    );
  }
}

