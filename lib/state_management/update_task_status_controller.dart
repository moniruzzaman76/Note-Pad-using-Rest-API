import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../data/Utils/urls.dart';
import '../data/service/network_coller.dart';
import '../data/service/network_response.dart';

class UpdateTaskStatusController extends  GetxController{

  bool _updateTaskInProgress = false;
  bool get updateTaskInProgress => _updateTaskInProgress;

  Future<bool> updateTask(String taskId, String newStatus) async {
    _updateTaskInProgress = true;
    update();
    final NetworkResponse response =
    await NetWorkCaller().getRequest(Urls.updateTask(taskId, newStatus));
    _updateTaskInProgress = false;
    update();
    if (response.isSuccess) {
      Get.snackbar(
        "Task Status", "update successfully done",
          backgroundColor: CupertinoColors.activeGreen,
          colorText: CupertinoColors.white
      );
      return true;
    } else {
      Get.snackbar(
        "Update Status", "failed!.try again",
          backgroundColor: CupertinoColors.destructiveRed,
          colorText: CupertinoColors.white
      );
      return false;
    }
  }

}