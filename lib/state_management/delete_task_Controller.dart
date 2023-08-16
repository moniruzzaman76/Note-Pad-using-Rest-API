import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/data/model/task_list_model.dart';
import '../data/Utils/urls.dart';
import '../data/service/network_coller.dart';
import '../data/service/network_response.dart';

class DeleteTaskController extends GetxController{


  final TaskListModel _taskListModel = TaskListModel();


  Future<bool> deleteTask(taskId) async {

    final NetworkResponse response =
    await NetWorkCaller().getRequest(Urls.deleteTask(taskId));

    if (response.isSuccess) {
      _taskListModel.data?.removeWhere((element) => element.sId == taskId);
      Get.snackbar("Delete!", "delete Successful.try again");
      update();
      return true;

    } else {
      Get.snackbar("Delete!", "delete failed.try again",backgroundColor: CupertinoColors.destructiveRed);
      return false;
    }
  }


}