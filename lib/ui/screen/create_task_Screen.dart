import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/state_management/create_task_controller.dart';
import '../../widgets/user_profile_banar.dart';
import 'bottom_nab_bar_screen.dart';

class CreateNewTaskScreen extends StatefulWidget {
  const CreateNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewTaskScreen> createState() => _CreateNewTaskScreenState();
}

class _CreateNewTaskScreenState extends State<CreateNewTaskScreen> {

  final TextEditingController _subjectEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
               InkWell(
                 onTap:(){} ,
                   child: const UserProfileBanner(),
               ),
              const SizedBox(height: 60),
              Text("Add New Task",
                style: Theme.of(context).textTheme.titleLarge,),

              const SizedBox(height: 30,),

              TextFormField(
                controller: _subjectEditingController,
                decoration: const InputDecoration(
                  hintText: "Enter your Title",
                  prefixIcon: Icon(Icons.title_outlined),
                ),
              ),

              const SizedBox(height: 20,),

              TextFormField(
                controller: _descriptionEditingController,
                maxLines: 8,
                decoration: const InputDecoration(
                  hintText: "Enter your Description",
                ),
              ),

              const SizedBox(height: 20,),

              GetBuilder<CreateTaskController>(

                builder: (createTaskController) {
                  return SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: createTaskController.addTaskInProgress == false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: (){
                             createTaskController.addNewTask(
                                 _subjectEditingController.text.trim(),
                                 _descriptionEditingController.text.trim()
                             ).then((result){
                               if(result == true){
                                 _subjectEditingController.clear();
                                 _descriptionEditingController.clear();
                                 Get.to(const BottomNabBarScreen());
                               }
                             });

                            },
                            child: const Icon(Icons.arrow_circle_right_outlined,size: 30,)
                        ),
                      ),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      )
    );
  }
}
