import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../data/Utils/urls.dart';
import '../data/model/task_list_model.dart';
import '../data/service/network_coller.dart';
import '../data/service/network_response.dart';

class NewTaskController extends GetxController{

  bool _addNewTaskInProgress = false;
  bool get addNewTaskInProgress => _addNewTaskInProgress;

  TaskListModel _taskListModel = TaskListModel();
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getNewTaskList() async {
    _addNewTaskInProgress = true;
    update();

      final NetworkResponse response = await NetWorkCaller().getRequest(Urls.newTaskList);
      _addNewTaskInProgress = false;
      update();

      if (response.isSuccess) {
        _taskListModel = TaskListModel.fromJson(response.body!);
        return true;
      } else {
        Get.snackbar(
            "Task Add", "Failed.try again!",
            backgroundColor: CupertinoColors.destructiveRed,
            colorText: CupertinoColors.white
        );
        return false;
      }
    }
  }
