import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/app/data/models/tasks.dart';
import 'package:waiter/app/global_widgets/EmptyOrdersWidget.dart';
import 'package:waiter/app/modules/tasks/controllers/tasks_controller.dart';
import 'package:waiter/app/routes/app_pages.dart';

class CompleteTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetX<TasksController>(
          builder: (_con) {
            return RefreshIndicator(
              onRefresh: _con.refreshCompletedTasks,
              child:_con.taskListCompleted.isEmpty ? EmptyOrdersWidget(): ListView.builder(
                itemCount:_con.taskListCompleted.length ,
                itemBuilder: (context, index) {

                  Tasks task=_con.taskListCompleted[index];
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
                      Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 10),
                        child: Divider(thickness: 1,indent: 1,endIndent: 2,height: 5,color: Colors.black,),
                      ),
                    ],
                  );
                },
              ),
            );
          }
      ),
    );
  }
}
