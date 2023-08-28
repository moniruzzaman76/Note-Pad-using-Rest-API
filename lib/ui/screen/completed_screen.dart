import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/state_management/completed_task_controller.dart';
import 'package:task_manager_project/ui/screen/show_delete_task.dart';
import 'package:task_manager_project/ui/screen/update_profile_screen.dart';
import 'package:task_manager_project/ui/screen/update_task_status_sheet.dart';
import '../../data/model/task_list_model.dart';
import '../../widgets/list_tile_task.dart';
import '../../widgets/user_profile_banar.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  

  final CompletedTaskController _completedTaskController = Get.find();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>const UpdateProfileScreen()));
              },
                child: const UserProfileBanner()
            ),

            GetBuilder<CompletedTaskController>(
              builder: (completedTaskController) {
                return Expanded(
                    child: RefreshIndicator(
                      onRefresh: ()async{
                        await completedTaskController.getCompletedTaskList();
                      },
                      child: Visibility(
                        visible: !completedTaskController.completedTaskInProgress,
                        replacement: const Center(child: CircularProgressIndicator()),
                        child: ListView.separated(
                          itemCount: completedTaskController.taskListModel.data?.length ?? 0,
                          itemBuilder: (context,index){
                            return  ListTileTask(
                              onDeleteTap: (){
                                _deleteTask(completedTaskController.taskListModel.data![index]);
                              },
                              onEditTap: (){
                                showStatusUpdateBottomSheet(completedTaskController.taskListModel.data![index]);
                              },
                              data: completedTaskController.taskListModel.data![index],
                              color: Colors.green,);
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
                );
              }
            )
          ],
        ),
      ),
    );
  }





  void _deleteTask(TaskData task){
    showDialog(context: context, builder: (context){
      return ShowDeleteTask(
        task: task,
        onDeleteTab: (){
          _completedTaskController.getCompletedTaskList();
        },
      );
    });
  }



  void showStatusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheet(task: task, onUpdate: () {
          _completedTaskController.getCompletedTaskList();
        });
      },
    );
  }


}
