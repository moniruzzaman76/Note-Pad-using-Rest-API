import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/state_management/inProgress_task_controller.dart';
import 'package:task_manager_project/ui/screen/show_delete_task.dart';
import 'package:task_manager_project/ui/screen/update_profile_screen.dart';
import 'package:task_manager_project/ui/screen/update_task_status_sheet.dart';
import '../../data/model/task_list_model.dart';
import '../../widgets/list_tile_task.dart';
import '../../widgets/user_profile_banar.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({Key? key}) : super(key: key);

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {

  final InProgressTaskController _inProgressTaskController = Get.find();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inProgressTaskController.getInProgressTaskList();
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: (){
               Get.to(const UpdateProfileScreen());
              } ,
                child: const UserProfileBanner(),
            ),
            GetBuilder<InProgressTaskController>(
              builder: (inProgressTaskController) {
                return Expanded(
                    child: RefreshIndicator(
                      onRefresh: ()async{
                        await  inProgressTaskController.getInProgressTaskList();
                      },
                      child: Visibility(
                        visible: !inProgressTaskController.progressTaskInProgress,
                        replacement: const Center(child: CircularProgressIndicator(),),
                        child: ListView.separated(
                          itemCount: inProgressTaskController.taskListModel.data?.length ?? 0,
                          itemBuilder: (context,index){
                             return  ListTileTask(
                               data:inProgressTaskController.taskListModel.data![index],
                               color: Colors.pink,
                               onDeleteTap: () {
                                 _deleteTask(inProgressTaskController.taskListModel.data![index]);
                               },
                               onEditTap: () {
                                 showStatusUpdateBottomSheet(inProgressTaskController.taskListModel.data![index]);
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
          _inProgressTaskController.getInProgressTaskList();
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
          _inProgressTaskController.getInProgressTaskList();
        });
      },
    );
  }


}
