import 'package:flutter/material.dart';
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
          color: Colors.blue
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
