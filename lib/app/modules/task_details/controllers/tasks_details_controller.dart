import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/data/models/task_checkitem.dart';
import 'package:waiter/app/data/models/tasks.dart';
import 'package:waiter/app/data/providers/tasks_provider.dart';
import 'package:waiter/app/global_widgets/helpers.dart';
import 'package:waiter/app/global_widgets/loading_dialog.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';

class TasksDetailsController extends GetxController {
  final authController =Get.find<AuthController>();
 final Widget paddingDividerWidget=  Padding(
   padding: const EdgeInsets.only(top: 10,bottom: 10),
   child: Divider(thickness: 1,indent: 1,endIndent: 2,height: 5,color: Colors.grey,),
 );
  var isLoading = true.obs;
  final _tasks = Tasks().obs;
  Tasks get tasks=>_tasks.value;
  // List<Sales> get salesList=>_salesList.value;
  final _taskId=''.obs;
  String get taskId=>_taskId.value;
  @override
  void onInit() async {
    super.onInit();
    if(Get.arguments !=null && Get.arguments.length>0){
      _taskId.value=Get.arguments['taskId'];
      await getSingleTasks();
      print(taskId);
      print('taskId====');
    }
    print('on init');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  Future<void> getSingleTasks() async {
    try {
      if(await authController.checkInternetConnectivity()) {
        isLoading(true);
        var tasksValue = await TasksProvider().getOneTasks(taskId);
        if (tasksValue != null) {
          _tasks.value = tasksValue;
        } else {
          _tasks.value = null;
        }
      }else{
        Helpers.showSnackbar(title:'error',message: 'error_dialog__no_internet'.tr);
      }
    } finally {
      isLoading(false);
    }
  }

  void changedCheckList(bool value,String taskId, TaskCheckItemModel taskCheckItemModel){
    if(value==true){
      updateTaskCheckList(id:taskCheckItemModel.id, taskId:taskId, finished:'1');
    }else{
      updateTaskCheckList(id:taskCheckItemModel.id, taskId:taskId, finished:'0');
    }
  }
 void updateTaskCheckList({String id,String taskId,String finished}) async {
   final ProgressDialog progressDialog = loadingDialog(Get.overlayContext);
   try{
     TaskCheckItemModel taskCheck=TaskCheckItemModel();
     taskCheck.id=id;
     taskCheck.taskid=taskId;
     taskCheck.finished=finished;
     taskCheck.user_id=authController.currentUser.id;
     taskCheck.apiKey=MrConfig.mr_api_key;
       if (await authController.checkInternetConnectivity()) {
         progressDialog.show();
         TasksProvider().updateTaskCheckItem(taskCheck).then((result)async {
           if (result != null ) {
             progressDialog.hide();
             await getSingleTasks();
             Helpers.showSnackbar(title:'success'.tr,message: 'your_tasks_has_been_successfully_update'.tr);
           } else {
             progressDialog.hide();
             Helpers.showSnackbar(title:"error".tr,message:"Failed".tr,);
           }
         });
       }else {
         Helpers.showSnackbar(message: 'error_dialog__no_internet'.tr);
     }
   }catch(e){
     progressDialog.hide();
     Helpers.showSnackbar(title:"error".tr,message:"Failed".tr,);
     print(e);
   }finally{
     progressDialog.hide();
   }
 }
}
