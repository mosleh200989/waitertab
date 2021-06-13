import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/data/models/Task.dart';
import 'package:waiter/app/data/providers/tasks_provider.dart';
import 'package:waiter/app/global_widgets/helpers.dart';
import 'package:waiter/app/global_widgets/loading_dialog.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';

class TasksController extends GetxController with SingleGetTickerProviderMixin {
  final AuthController authController=Get.find();
  TabController tabController;
 final isLoadingPending=true.obs;
 final isLoadingCompleted=true.obs;
  var taskListPending = <Task>[].obs;
  var taskListCompleted = <Task>[].obs;
  String statusData='Mr';
  String priorityData='';
  @override
  void onInit()async {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
    await getAllTasks();
    await getAllCompleted();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
void changeStatus(String value,int index){
    taskListPending[index].statusValue=value;
    if(value=='Not Started'){
      taskListPending[index].statusValue=value;
      taskListPending[index].status='1';
      taskListPending.refresh();
      updateTaskStatus(taskListPending[index].id,taskListPending[index].status);
    }else if(value=='Awaiting Feedback'){
      print(value);
      taskListPending[index].statusValue=value;
      taskListPending[index].status='2';
      taskListPending.refresh();
    }else if(value=='Testing'){
      taskListPending[index].statusValue=value;
      taskListPending[index].status='3';
      taskListPending.refresh();
    }else if(value=='In Progress'){
      taskListPending[index].statusValue=value;
      taskListPending[index].status='4';
      taskListPending.refresh();
    }else{
      taskListPending[index].statusValue=value;
      taskListPending[index].status='5';
      taskListPending.refresh();
    }

}
  Future<void> getAllTasks() async {
    try {
      isLoadingPending(true);
      var taskValue = await TasksProvider().getTasks();
      if (taskValue != null) {
        isLoadingPending(false);
        taskListPending.assignAll(taskValue);
        // salesList.value = salesValue;
      }else{
        taskListPending.value=[];
      }
    } finally {
      isLoadingPending(false);
    }
  }
  Future<void> getAllCompleted() async {
    try {
      isLoadingCompleted(true);
      var taskValue = await TasksProvider().getTasksCompleted();
      if (taskValue != null) {
        isLoadingCompleted(false);
        taskListCompleted.assignAll(taskValue);
        // salesList.value = salesValue;
      }else{
        taskListPending.value=[];
      }
    } finally {
      isLoadingCompleted(false);
    }
  }

  void updateTaskStatus(String id,String status ) async {
    final ProgressDialog progressDialog = loadingDialog(Get.overlayContext);
    try{
      Task task=Task();
      task.id=id;
      task.status=status;
      task.user_id=authController.currentUser.id;
      task.apiKey=MrConfig.mr_api_key;
      print(task.toMap());
      print('.status');
     if(task==null){
        Helpers.showSnackbar(title:'error'.tr,message: 'please_select_payment_method'.tr);
      }else{
        if (await authController.checkInternetConnectivity()) {
          // progressDialog.show();
       /*   TasksProvider().updateTask(task).then((result) {
            print(result);
            print('result===');
            if (result != null ) {
              progressDialog.hide();
              // isProcessing(false);
              Helpers.showSnackbar(title:'success'.tr,message: 'your_order_has_been_successfully_submitted'.tr);
            } else {
              progressDialog.hide();
              Helpers.showSnackbar(title:"error".tr,message:"Failed".tr,);
            }
          });*/
        }else {
          Helpers.showSnackbar(message: 'error_dialog__no_internet'.tr);
        }
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
