import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../data/Utils/urls.dart';
import '../data/service/network_coller.dart';
import '../data/service/network_response.dart';

class CreateTaskController extends GetxController{


  bool _addTaskInProgress = false;
  bool get addTaskInProgress => _addTaskInProgress;

  Future<bool>addNewTask(String title,String description)async{
    _addTaskInProgress = true;
   update();
    final NetworkResponse response = await NetWorkCaller().postRequest(Urls.createTask, <String,dynamic>{

      "title":title,
      "description":description,
      "status":"New"
    });
    _addTaskInProgress = false;
    update();
    if(response.isSuccess){
      Get.snackbar(
          "Task Add", "successfully done!",
          backgroundColor: CupertinoColors.white,
          colorText: CupertinoColors.activeGreen
      );
      return true;
    }else{
      Get.snackbar(
          "Task Add", "Failed.try again!",
          backgroundColor: CupertinoColors.white,
          colorText: CupertinoColors.activeGreen
      );
      return false;
    }

  }

}