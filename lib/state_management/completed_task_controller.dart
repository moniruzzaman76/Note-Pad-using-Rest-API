import 'package:get/get.dart';
import '../data/Utils/urls.dart';
import '../data/model/task_list_model.dart';
import '../data/service/network_coller.dart';
import '../data/service/network_response.dart';

class CompletedTaskController extends GetxController{


  bool _completedTaskInProgress = false;
  bool get completedTaskInProgress=>_completedTaskInProgress;

  TaskListModel _taskListModel = TaskListModel();
  TaskListModel get taskListModel => _taskListModel;

  Future<void>getCompletedTaskList()async{

    _completedTaskInProgress = true;
     update();

      final NetworkResponse response = await NetWorkCaller().getRequest(Urls.completedTaskList);

      _completedTaskInProgress = false;
     update();
      if(response.isSuccess){
        _taskListModel = TaskListModel.fromJson(response.body!);
      }else{
        Get.snackbar("completed Task", "get failed!.try again");
      }
    }
  }


