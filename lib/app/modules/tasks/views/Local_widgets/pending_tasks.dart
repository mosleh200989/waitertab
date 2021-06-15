import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/tasks.dart';
import 'package:waiter/app/global_widgets/EmptyOrdersWidget.dart';
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
            child: _con.taskListPending.isEmpty ? EmptyOrdersWidget(): ListView.builder(
             itemCount:_con.taskListPending.length ,
              itemBuilder: (context, index) {

               Tasks task=_con.taskListPending[index];
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

               return   Column(
                 children: [
                   Container(
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex:2,
                              child: Column(
                                children: [
                                  Text('${task.name}',textAlign: TextAlign.center,),
                                  SizedBox(height: 10,),
                                  Text('${_con.priorityData}',textAlign: TextAlign.center,),
                                ],
                              )),
                          Expanded(
                              flex:2,
                              child: Column(
                                children: [
                                  Text('${task.startdate}',textAlign: TextAlign.center),
                                  Text('To',textAlign: TextAlign.center),
                                  Text('${task.duedate}',textAlign: TextAlign.center),
                                ],
                              )),
                          Expanded(
                              flex:2,
                                  child: Column(
                                    children: [
                                      // Text('${_con.statusData}'),
                                      ElevatedButton(
                                        onPressed: () {
                                          if(task.status=='1'){
                                            _con.statusIndex=0;
                                            _con.statusData='Not Started';
                                          }else if(task.status=='2'){
                                            _con.statusIndex=1;
                                            _con.statusData='Awaiting Feedback';
                                          }else if(task.status=='3'){
                                            _con.statusIndex=2;
                                            _con.statusData='Testing';
                                          }else if(task.status=='4'){
                                            _con.statusIndex=3;
                                            _con.statusData='In Progress';
                                          }else{
                                            _con.statusIndex=4;
                                            _con.statusData='Complete';
                                          }
                                          showStatusDailog(task,index);

                                      },
                                        child: Text('${task.statusValue??''}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blueGrey
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                       Get.toNamed(Routes.TASK_DETAILS,arguments:{'taskId':task.id} );
                                        },
                                        child: Text('details'.tr,style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.blueGrey,
                                          fixedSize: Size(100.0, 0.0)
                                        ),
                                      ),

                                    ],
                                  ),
                               ),
                        ],
                      ),
                   ),
                   Divider(thickness: 1,indent: 1,endIndent: 2,height: 5,color: Colors.black,),
                 ],
               );
              },
            ),
          );
        }
      ),
    );
  }
  Widget showStatusDailog(Tasks task,int index){
    final taskController=Get.find<TasksController>();
List<String> statusList=<String>[
  'Not Started',
  'Awaiting Feedback',
  'Testing',
  'In Progress',
  'Complete'
];
    Get.defaultDialog(
      title: 'ChangeStatus'.tr,
      titleStyle: TextStyle(fontSize: 24,),
      content: SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<TasksController>(
            builder: (_) {
              return Container(
                height: 220,
                child: ListView.builder(
                  itemCount: statusList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    String statusName=statusList[index];
                  return GestureDetector(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(2),
                            padding: EdgeInsets.all(3),
                            height: 30,
                            color: taskController.statusIndex==index? Colors.blueGrey:null,
                            child: Text('${statusList[index]}',textAlign: TextAlign.justify,)),
                        Padding(
                          padding: const EdgeInsets.only(top:3,bottom:3),
                          child: Divider(thickness: 1,indent: 1,endIndent: 2,height: 5,color: Colors.grey,),
                        )
                      ],
                    ),
                    onTap: () {
                      taskController.changeStatus(statusName,index,task.id);

                    },
                  );
                },),
              );
            }
          ),
        ),
      ),
      confirm: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: ElevatedButton(
                onPressed: () {
                  taskController.updateTaskStatus();
            }, child: Text( 'Update'.tr),
            style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey,
              fixedSize: Size(100, 0.0)
            ),

            ),
          )
        ],
      )
    );
  }
}

