import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_management/cancel _task_controller.dart';
import '../../state_management/completed_task_controller.dart';
import '../../state_management/inProgress_task_controller.dart';
import '../../state_management/new_task_controller.dart';
import '../../state_management/summery_count_controller.dart';
import 'cancel_screen.dart';
import 'completed_screen.dart';
import 'inprogress_screen.dart';
import 'new_task_screen.dart';

class BottomNabBarScreen extends StatefulWidget {
  const BottomNabBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNabBarScreen> createState() => _BottomNabBarScreenState();
}

class _BottomNabBarScreenState extends State<BottomNabBarScreen> {


  final InProgressTaskController _inProgressTaskController = Get.find();
  final CancelTaskController _cancelTaskController = Get.find();
  final CompletedTaskController _completedTaskController = Get.find();
  final NewTaskController _newTaskController = Get.find<NewTaskController>();
  final SummeryCountController _summeryCountController = Get.find<SummeryCountController>();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _summeryCountController.getSummeryCount();
      _newTaskController.getNewTaskList();
      _completedTaskController.getCompletedTaskList();
      _cancelTaskController.getCancelTaskList();
      _inProgressTaskController.getInProgressTaskList();

    });
  }

  int selectedIndex = 0;

  final List<Widget>_screen=[
    const NewTaskScreen(),
    const CompletedScreen(),
    const CancelScreen(),
    const InProgressScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_screen[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: const IconThemeData(
          color: Colors.teal
        ),
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey,
        ),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: (index){
          selectedIndex = index;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit,),label: "New Task",),
          BottomNavigationBarItem(icon: Icon(Icons.done_all,),label: "Completed",),
          BottomNavigationBarItem(icon: Icon(Icons.cancel_outlined,),label: "Cancel",),
          BottomNavigationBarItem(icon: Icon(Icons.account_tree_outlined,),label: "In Progress",),
        ],
      ),

    );
  }
}
