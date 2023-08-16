import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/state_management/new_task_controller.dart';
import 'package:task_manager_project/state_management/summery_count_controller.dart';
import 'package:task_manager_project/ui/screen/show_delete_task.dart';
import 'package:task_manager_project/ui/screen/update_profile_screen.dart';
import 'package:task_manager_project/ui/screen/update_task_status_sheet.dart';
import '../../data/model/task_list_model.dart';
import '../../widgets/list_tile_task.dart';
import '../../widgets/summery_card.dart';
import '../../widgets/user_profile_banar.dart';
import 'create_task_Screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {



  final SummeryCountController _summeryCountController = Get.find<SummeryCountController>();
   final NewTaskController _newTaskController = Get.find<NewTaskController>();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _summeryCountController.getSummeryCount();
      _newTaskController.getNewTaskList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(const UpdateProfileScreen());
              },
              child: const UserProfileBanner(),
            ),

            //  Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: _summeryCountInProgress ? const LinearProgressIndicator() :
            //   const Row(
            //     children: [
            //       SummeryCard(
            //         count: '5',
            //         title: "New Task",
            //       ),
            //       SummeryCard(
            //         count: '4',
            //         title: "In Progress",
            //       ),
            //       SummeryCard(
            //         count: '4',
            //         title: "Completed",
            //       ),
            //       SummeryCard(
            //         count: '3',
            //         title: "Cancel",
            //       ),
            //     ],
            //   ),
            // ),

            GetBuilder<SummeryCountController>(
              builder: (summeryCountController) {
                return Visibility(
                  visible: !summeryCountController.getCountSummaryInProgress,
                  replacement: const LinearProgressIndicator(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: summeryCountController.summaryCountModel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return SummeryCard(
                            count: summeryCountController.summaryCountModel.data![index].sum.toString(),
                            title: summeryCountController.summaryCountModel.data![index].sId ?? "New",
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 4,
                            thickness: 1,
                          );
                        },
                      ),
                    ),
                  ),
                );
              }
            ),

            Expanded(
                child: RefreshIndicator(
              color: Colors.red,
              backgroundColor: Colors.white70,
              onRefresh: () async {
                _newTaskController.getNewTaskList();
                _summeryCountController.getSummeryCount();

              },
              child: GetBuilder<NewTaskController>(

                builder: (newTaskController) {
                  return Visibility(
                    visible: newTaskController.addNewTaskInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ListView.separated(
                      itemCount: newTaskController.taskListModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ListTileTask(
                          data: newTaskController.taskListModel.data![index],
                          onDeleteTap: () {
                           _deleteTask(newTaskController.taskListModel.data![index]);
                          },
                          onEditTap: () {
                            showStatusUpdateBottomSheet(newTaskController.taskListModel.data![index]);
                          },
                          color: Colors.lightBlue,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 4,
                          thickness: 1,
                        );
                      },
                    ),
                  );
                }
              ),
            ))

            // const ListTileTask(text:"New",color: Colors.blue,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Get.to(const CreateNewTaskScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _deleteTask(TaskData task){
    showDialog(context: context, builder: (context){
      return ShowDeleteTask(
       task: task,
        onDeleteTab: (){
          _newTaskController.getNewTaskList();
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
          _newTaskController.getNewTaskList();
        });
      },
    );
  }

}


