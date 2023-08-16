import 'package:get/get.dart';

import '../data/Utils/urls.dart';
import '../data/model/task_list_model.dart';
import '../data/service/network_coller.dart';
import '../data/service/network_response.dart';

class CancelTaskController extends GetxController{


  TaskListModel _taskListModel = TaskListModel();
  TaskListModel get taskListModel => _taskListModel;

  bool _cancelTaskInProgress = false;
  bool get cancelTaskInProgress => _cancelTaskInProgress;

  Future<void>getCancelTaskList()async{

    _cancelTaskInProgress = true;
    update();

      final NetworkResponse response = await NetWorkCaller().getRequest(Urls.cancelledTaskList);

      _cancelTaskInProgress = false;
     update();

      if(response.isSuccess){
        _taskListModel = TaskListModel.fromJson(response.body!);
      }else{
        Get.snackbar("Cancel Task", "get failed!.try again");
      }
    }
  }

