import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/screen/update_profile_screen.dart';
import 'package:task_manager_project/ui/screen/update_task_status_sheet.dart';
import '../../data/Utils/urls.dart';
import '../../data/model/task_list_model.dart';
import '../../data/service/network_coller.dart';
import '../../data/service/network_response.dart';
import '../../widgets/list_tile_task.dart';
import '../../widgets/user_profile_banar.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({Key? key}) : super(key: key);

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getInProgressTaskList();
    });
  }

  bool progressTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  Future<void>getInProgressTaskList()async{

    progressTaskInProgress = true;
    if(mounted){
      setState(() {});

      final NetworkResponse response = await NetWorkCaller().getRequest(Urls.inProgressTaskList);

      progressTaskInProgress = false;
      if(mounted){
        setState(() {});
      }
      if(response.isSuccess){
        _taskListModel = TaskListModel.fromJson(response.body!);
      }else{
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("InProgress Task get failed!")));
        }
      }
    }
  }


  Future<void> deleteTask(taskId) async {
    final NetworkResponse response =
    await NetWorkCaller().getRequest(Urls.deleteTask(taskId));
    if (response.isSuccess) {

      _taskListModel.data?.removeWhere((element) => element.sId == taskId);
      // getNewTaskList();
      // getSummeryCount();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red, content: Text("Task delete failed!")));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>const UpdateProfileScreen()));
              } ,
                child: const UserProfileBanner(),
            ),
            Expanded(
                child: RefreshIndicator(
                  onRefresh: ()async{
                    await  getInProgressTaskList();
                  },
                  child: Visibility(
                    visible: !progressTaskInProgress,
                    replacement: const Center(child: CircularProgressIndicator(),),
                    child: ListView.separated(
                      itemCount: _taskListModel.data?.length ?? 0,
                      itemBuilder: (context,index){
                         return  ListTileTask(
                           data:_taskListModel.data![index],
                           color: Colors.pink,
                           onDeleteTap: () {
                             _showDeleteDialog(index);
                           },
                           onEditTap: () {
                             showStatusUpdateBottomSheet(_taskListModel.data![index]);
                           },
                         );
                      },
                      separatorBuilder: (context,index){
                        return const Divider(
                          height: 4,
                          thickness: 1,
                        );
                      },

                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(index){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Center(
            child: Text("Delete!",style: TextStyle(color:Colors.red),)),
        content: const Text("Do you want to delete task?",style:TextStyle(
          fontSize: 22,
        ),),
        actions: [
          Row(
            children: [
              TextButton(
                  onPressed: (){
                    getInProgressTaskList();
                    deleteTask(_taskListModel.data![index].sId);
                    Navigator.pop(context);
                    if(mounted){
                      setState(() {});
                    }
                  }, child: const Text("Yes",style: TextStyle(
                  fontSize: 20,
                  color: Colors.red
              ),)),
              const Spacer(),
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text("NO",style: TextStyle(
                fontSize: 20,
              ),)),

            ],
          )
        ],
      );
    });
  }


  void showStatusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheet(task: task, onUpdate: () {
          getInProgressTaskList();
        });
      },
    );
  }


}
