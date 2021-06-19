import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:waiter/app/core/values/mr_config.dart';
import 'package:waiter/app/core/values/mr_constants.dart';
import 'package:waiter/app/data/models/pagination_filter.dart';
import 'package:waiter/app/data/models/tasks.dart';
import 'package:waiter/app/data/providers/tasks_provider.dart';
import 'package:waiter/app/global_widgets/helpers.dart';
import 'package:waiter/app/global_widgets/loading_dialog.dart';
import 'package:waiter/app/modules/home/controllers/app_controller.dart';
import 'package:waiter/app/modules/home/controllers/auth_controller.dart';

class TasksController extends GetxController with SingleGetTickerProviderMixin {
  final AuthController authController=Get.find();
  TabController tabController;
  ScrollController scrollController = ScrollController();
  ScrollController scrollControllerComplete = ScrollController();
 final isLoadingPending=true.obs;
 final isLoadingCompleted=true.obs;
  var isMoreDataAvailablePending = true.obs;
  var isMoreDataAvailableComplete = true.obs;
  var taskListPending = <Tasks>[].obs;
  var taskListCompleted = <Tasks>[].obs;
  final _paginationFilterPending = PaginationFilter().obs;
  final _paginationFilterCompleted = PaginationFilter().obs;
  int get limitPending => _paginationFilterPending.value.limit;
  int get offsetPending => _paginationFilterPending.value.offset;
  int get limitCompleted => _paginationFilterCompleted.value.limit;
  int get offsetCompleted => _paginationFilterCompleted.value.offset;
  String taskId='';
  String statusId='';
  String statusData='';
  String priorityData='';
  int statusIndex;
  @override
  void onInit()async {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
    _changePaginationFilterPending(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    _changePaginationFilterCompleted(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    await getAllTasks(_paginationFilterPending.value);
    await getAllCompleted(_paginationFilterCompleted.value);
    paginatePendingList();
    paginateCompletedList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void _changePaginationFilterPending(int offset, int limit) {
    _paginationFilterPending.update((val) {
      val.offset = offset;
      val.limit = limit;
    });
  }
    void _changePaginationFilterCompleted(int offset, int limit) {
      _paginationFilterCompleted.update((val) {
        val.offset = offset;
        val.limit = limit;
      });
    }
      void paginatePendingList() {
        scrollController.addListener(() async {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent)  {
            print("reached end");
            _changePaginationFilterPending(offsetPending + limitPending, limitPending);
            await getMoreAllTasks(_paginationFilterPending.value);
            // page++;
            // getMoreTask(page);
          }
        });
      }
      void paginateCompletedList() {
        scrollControllerComplete.addListener(() async {
          if (scrollControllerComplete.position.pixels ==
              scrollControllerComplete.position.maxScrollExtent)  {
            print("reached end");
            _changePaginationFilterCompleted(offsetCompleted + limitCompleted, limitCompleted);
            await getMoreCompletedTasks(_paginationFilterCompleted.value);
            // page++;
            // getMoreTask(page);
          }
        });
      }
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
  Future<void> getAllTasks(PaginationFilter filter) async {
    try {
      isMoreDataAvailablePending(false);
      isLoadingPending(true);
      var taskValue = await TasksProvider().getTasks(filter);
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

      Future<void> getMoreAllTasks(PaginationFilter filter)async{
        print('getMoreAllTasks');
        try{
          var taskValue = await TasksProvider().getTasks(filter);
          if (taskValue.length > 0) {
            isMoreDataAvailablePending(true);
          } else {
            isMoreDataAvailablePending(false);
          }
          taskListPending.addAll(taskValue);
        }catch (exception) {
          isLoadingPending(false);
        }finally{
          isLoadingPending(false);
        }
      }
  Future<void> getAllCompleted(PaginationFilter filter) async {
    print('cal completed');
    try {
      isMoreDataAvailableComplete(false);
      isLoadingCompleted(true);
      var taskValue = await TasksProvider().getTasksCompleted(filter);
      print(taskValue.length);
      print('taskValue.length');
      if (taskValue != null) {
        isLoadingCompleted(false);
        taskListCompleted.assignAll(taskValue);
        // salesList.value = salesValue;
      }else{
        taskListCompleted.value=[];
      }
    } finally {
      isLoadingCompleted(false);
    }
  }
      Future<void> getMoreCompletedTasks(PaginationFilter filter)async{
        print('getMoreCompletedTasks');
        try{
          var taskValue = await TasksProvider().getTasksCompleted(filter);
          if (taskValue.length > 0) {
            isMoreDataAvailableComplete(true);
          } else {
            isMoreDataAvailableComplete(false);
          }
          taskListCompleted.addAll(taskValue);
        }catch (exception) {
          isLoadingCompleted(false);
        }finally{
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
              await getAllTasks(_paginationFilterPending.value);
              await getAllCompleted(_paginationFilterCompleted.value);
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
  Future<void> refreshPendingTasks() async {
    taskListPending.clear();
    _changePaginationFilterPending(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    await getAllTasks(_paginationFilterPending.value);
    Helpers.showSnackbar(title:'success'.tr,message: 'refreshed_successfully_completed'.tr);
  }
  Future<void> refreshCompletedTasks() async {
    taskListCompleted.clear();
    _changePaginationFilterCompleted(MrConst.LOADING_OFFSET,MrConst.LOADING_LIMIT);
    await getAllCompleted(_paginationFilterCompleted.value);
    Helpers.showSnackbar(title:'success'.tr,message: 'refreshed_successfully_completed'.tr);
  }

}
