import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/state_management/cancel%20_task_controller.dart';
import 'package:task_manager_project/ui/screen/show_delete_task.dart';
import 'package:task_manager_project/ui/screen/update_profile_screen.dart';
import 'package:task_manager_project/ui/screen/update_task_status_sheet.dart';
import '../../data/model/task_list_model.dart';
import '../../widgets/list_tile_task.dart';
import '../../widgets/user_profile_banar.dart';

class CancelScreen extends StatefulWidget {
  const CancelScreen({Key? key}) : super(key: key);

  @override
  State<CancelScreen> createState() => _CancelScreenState();
}

class _CancelScreenState extends State<CancelScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cancelTaskController.getCancelTaskList();
    });
  }

  final CancelTaskController _cancelTaskController = Get.find();


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
            GetBuilder<CancelTaskController>(
              builder: (cancelTaskController) {
                return Expanded(
                    child: RefreshIndicator(
                      onRefresh: ()async{
                        await  cancelTaskController.getCancelTaskList();
                      },
                      child: Visibility(
                        visible: !cancelTaskController.cancelTaskInProgress,
                        replacement: const Center(child: CircularProgressIndicator(),),
                        child: ListView.separated(
                          itemCount: cancelTaskController.taskListModel.data?.length ?? 0,
                          itemBuilder: (context,index){
                            return  ListTileTask(
                              data:cancelTaskController.taskListModel.data![index],
                              color: Colors.red,
                              onDeleteTap: () {
                                _deleteTask(cancelTaskController.taskListModel.data![index]);
                              },
                              onEditTap: () {
                                showStatusUpdateBottomSheet(cancelTaskController.taskListModel.data![index]);
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
          _cancelTaskController.getCancelTaskList();
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
          _cancelTaskController.getCancelTaskList();
        });
      },
    );
  }

}
