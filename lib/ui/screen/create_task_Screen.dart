import 'package:flutter/material.dart';
import '../../data/Utils/urls.dart';
import '../../data/service/network_coller.dart';
import '../../data/service/network_response.dart';
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
  
  bool _addTaskInProgress = false;

  Future<void>addNewTask()async{
    _addTaskInProgress = true;
    if(mounted){
      setState(() {});
    }
    final NetworkResponse response = await NetWorkCaller().postRequest(Urls.createTask, <String,dynamic>{

      "title":_subjectEditingController.text.trim(),
      "description":_descriptionEditingController.text.trim(),
      "status":"New"
    });
    _addTaskInProgress = false;
    if(mounted){
      setState(() {});
    }

    if(response.isSuccess){
      _subjectEditingController.clear();
      _descriptionEditingController.clear();
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: (Text("Task Added Successful!"))));
      }
    }else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: (Text("Task add failed!"))));
      }
      _addTaskInProgress = false;
      if(mounted){
        setState(() {});
      }
    }

  }

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

              SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: _addTaskInProgress == false,
                  replacement: const Center(child: CircularProgressIndicator(),),
                  child: ElevatedButton(
                      onPressed: (){
                        addNewTask();
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context)=>const BottomNabBarScreen()));
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined,size: 30,)
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
