import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../data/Utils/urls.dart';
import '../data/model/task_list_model.dart';
import '../data/service/network_coller.dart';
import '../data/service/network_response.dart';

class InProgressTaskController extends GetxController{
  TaskListModel _taskListModel = TaskListModel();
  TaskListModel get taskListModel => _taskListModel;


  bool _progressTaskInProgress = false;
  bool get progressTaskInProgress=> _progressTaskInProgress;

  Future<void>getInProgressTaskList()async{

    _progressTaskInProgress = true;
     update();

      final NetworkResponse response = await NetWorkCaller().getRequest(Urls.inProgressTaskList);

      _progressTaskInProgress = false;
      update();
      if(response.isSuccess){
        _taskListModel = TaskListModel.fromJson(response.body!);
      }else{
        Get.snackbar(
            "failed", "Email verify failed!.try again",
            backgroundColor: CupertinoColors.destructiveRed,
            colorText: CupertinoColors.white
        );
      }
    }
  }

