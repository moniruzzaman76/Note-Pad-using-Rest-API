import 'package:flutter/material.dart';
import '../../data/Utils/urls.dart';
import '../../data/model/task_list_model.dart';
import '../../data/service/network_coller.dart';
import '../../data/service/network_response.dart';

class ShowDeleteTask extends StatefulWidget {
  final TaskData task;
  final VoidCallback onDeleteTab;
  const ShowDeleteTask({Key? key, required this.task, required this.onDeleteTab}) : super(key: key);

  @override
  State<ShowDeleteTask> createState() => _ShowDeleteTaskState();
}

class _ShowDeleteTaskState extends State<ShowDeleteTask> {

   final TaskListModel _taskListModel = TaskListModel();

   bool deleteInProgress = false;


  Future<void> deleteTask(taskId) async {

    deleteInProgress = true;
    if(mounted){
      setState(() {});
    }

    final NetworkResponse response =
    await NetWorkCaller().getRequest(Urls.deleteTask(taskId));

    deleteInProgress = true;
    if(mounted){
      setState(() {});
    }

    if (response.isSuccess) {

      _taskListModel.data?.removeWhere((element) => element.sId == taskId);

    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red, content: Text("Task delete failed!")));
      }
    }
  }





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
            TextButton(
                onPressed: (){
                  deleteTask(widget.task.sId.toString());
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
  }
}
