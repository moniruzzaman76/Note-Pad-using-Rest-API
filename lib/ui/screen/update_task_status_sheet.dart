import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/state_management/update_task_status_controller.dart';
import '../../data/model/task_list_model.dart';


class UpdateTaskStatusSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;

  const UpdateTaskStatusSheet(
      {Key? key, required this.task, required this.onUpdate})
      : super(key: key);

  @override
  State<UpdateTaskStatusSheet> createState() => _UpdateTaskStatusSheetState();
}

class _UpdateTaskStatusSheetState extends State<UpdateTaskStatusSheet> {
  List<String> taskStatusList = ['New', 'Completed', 'Cancelled', 'Progress'];
  late String _selectedTask;

  @override
  void initState() {
    _selectedTask = widget.task.status!.toLowerCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.all(16), child: Text('Update Status',style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.green
          ),)),
          Expanded(
            child: ListView.builder(
                itemCount: taskStatusList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      _selectedTask = taskStatusList[index];
                     if(mounted){
                       setState(() {});
                     }
                    },
                    title: Text(taskStatusList[index].toUpperCase()),
                    trailing: _selectedTask == taskStatusList[index]
                        ? const Icon(Icons.check_box,color: Colors.green,)
                        : null,
                  );
                }),
          ),
          GetBuilder<UpdateTaskStatusController>(
            builder: (updateTaskStatusController) {
              return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Visibility(
                      visible: updateTaskStatusController.updateTaskInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              updateTaskStatusController.updateTask(widget.task.sId!, _selectedTask);
                                  widget.onUpdate();
                                  Get.back();
                            },
                            child: const Text('Update',style: TextStyle(
                              fontSize: 20,
                            ),)),
                      )));
            }
          )
        ],
      ),
    );
  }
}