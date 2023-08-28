import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/state_management/delete_task_Controller.dart';
import '../../data/model/task_list_model.dart';

class ShowDeleteTask extends StatefulWidget {
  final TaskData task;
  final VoidCallback onDeleteTab;
  const ShowDeleteTask({Key? key, required this.task, required this.onDeleteTab}) : super(key: key);

  @override
  State<ShowDeleteTask> createState() => _ShowDeleteTaskState();
}

class _ShowDeleteTaskState extends State<ShowDeleteTask> {


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
          child: Text("Delete!",style: TextStyle(color:Colors.red),)),
      content: const Text("Do you want to delete task?",style:TextStyle(
        fontSize: 22,
      ),),
      actions: [
        Row(
          children: [
            GetBuilder<DeleteTaskController>(
              builder: (deleteTaskController) {
                return TextButton(
                    onPressed: (){
                      deleteTaskController.deleteTask(widget.task.sId.toString());
                      widget.onDeleteTab();
                      Get.back();

                    }, child: const Text("Yes",style: TextStyle(
                    fontSize: 20,
                    color: Colors.red
                ),));
              }
            ),
            const Spacer(),
            TextButton(onPressed: (){
              Get.back();
            }, child: const Text("NO",style: TextStyle(
              fontSize: 20,
            ),)),

          ],
        )
      ],
    );
  }
}
