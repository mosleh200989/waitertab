import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/data/models/tasks.dart';
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
  var taskListPending = <Tasks>[].obs;
  var taskListCompleted = <Tasks>[].obs;
  String taskId='';
  String statusId='';
  String statusData='';
  String priorityData='';
  int statusIndex;
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

void changeStatus(String value,int index,String id){
    statusIndex=index;
    if(value=='Not Started'){
      taskId=id;
      statusData=value;
      statusId='1';
    }else if(value=='Awaiting Feedback'){
      statusData=value;
      statusId='2';
      taskId=id;
    }else if(value=='Testing'){
      statusData=value;
      statusId='3';
      taskId=id;
    }else if(value=='In Progress'){
      statusData=value;
      statusId='4';
      taskId=id;
    }else{
      statusData=value;
      statusId='5';
      taskId=id;

    }
update();
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

  void updateTaskStatus() async {
    final ProgressDialog progressDialog = loadingDialog(Get.overlayContext);
    try{
      Tasks task=Tasks();
      task.id=taskId;
      task.status=statusId;
      task.user_id=authController.currentUser.id;
      task.apiKey=MrConfig.mr_api_key;
        if (await authController.checkInternetConnectivity()) {
          progressDialog.show();
          TasksProvider().updateTask(task).then((result)async {
            if (result != null ) {
              progressDialog.hide();
              Get.back();
              await getAllTasks();
              await getAllCompleted();
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
