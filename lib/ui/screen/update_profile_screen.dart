import 'package:flutter/material.dart';
import '../../data/Utils/urls.dart';
import '../../data/model/auth_utility.dart';
import '../../data/model/login_model.dart';
import '../../data/service/network_coller.dart';
import '../../data/service/network_response.dart';
import '../../widgets/background_images.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  // another Process for update
  //final TextEditingController _emailEditingController =TextEditingController(text: AuthUtility.userInfo.data?.email);

   UserData userData = AuthUtility.userInfo.data!;

  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final TextEditingController _firstNameEditingController = TextEditingController();
  final TextEditingController _lastNameEditingController = TextEditingController();
  final TextEditingController _mobileEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


   @override
  void initState() {
    super.initState();
    _emailEditingController.text =userData.email ?? "";
    _firstNameEditingController.text = userData.firstName ?? "";
    _lastNameEditingController.text = userData.lastName ?? "";
    _mobileEditingController.text = userData.mobile ?? "";
  }


  final ImagePicker picker = ImagePicker();
   XFile? imageFile;
   
   bool updateProfileInProgress = false;
   
   Future<void>updateProfile() async{
     updateProfileInProgress = true;
     if(mounted){
       setState(() {});
     }
     final Map<String,dynamic> requestBody = {
       "firstName": _firstNameEditingController.text.trim(),
       "lastName": _lastNameEditingController.text.trim(),
       "mobile": _mobileEditingController.text.trim(),
       "photo": "",
     };
     if(_passwordEditingController.text.isNotEmpty){
       requestBody["password"] = _passwordEditingController.text;
     }
     final NetworkResponse response = await NetWorkCaller().postRequest(Urls.profileUpdate, requestBody);
     updateProfileInProgress = false;
     if(mounted){
       setState(() {});
     }
     if(response.isSuccess){
      _passwordEditingController.clear();

      userData.firstName = _firstNameEditingController.text.trim();
      userData.lastName = _lastNameEditingController.text.trim();
      userData.mobile = _mobileEditingController.text.trim();

      AuthUtility.updateUserInfo(userData);


      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green, content: Text("Profile update successfully")));
      }
     }else{
       if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
             backgroundColor: Colors.red, content: Text("Profile update failed")));
       }
     }
   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: ScreenBackGround(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      Text("Update Profile",
                        style: Theme.of(context).textTheme.titleLarge,),

                      const SizedBox(height: 20,),

                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              selectedImage();
                            },
                            child: Container(
                              alignment: Alignment.center,
                            padding: const EdgeInsets.all(15),
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.only(
                                  topLeft:Radius.circular(7), bottomLeft: Radius.circular(7),
                                )
                              ),

                              child: const Text("Photo",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),),
                            ),
                          ),
                          Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(15),
                               decoration: const BoxDecoration(
                                 color: Colors.white,
                                   borderRadius: BorderRadius.only(
                                     topLeft:Radius.circular(7), bottomLeft: Radius.circular(7),
                                   )
                               ),
                                child: Visibility(
                                  visible: imageFile != null,
                                  child: Text( imageFile?.name ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                    color: Colors.black54,
                                  ),),
                                ),
                              )
                          )
                        ],
                      ),

                      const SizedBox(height: 20,),

                      TextFormField(
                        readOnly: true,
                        validator: (value){
                          if(value==null|| value.isEmpty){
                            return " Please Enter your email";
                          }
                          return null;
                        },
                        controller: _emailEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Enter your email",
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),

                      const SizedBox(height: 16,),

                      TextFormField(
                        validator: (value){
                          if(value==null|| value.isEmpty){
                            return " Please Enter your firs Name";
                          }
                          return null;
                        },
                        controller: _firstNameEditingController,
                        decoration: const InputDecoration(
                          hintText: "Enter your firs Name",
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),

                      const SizedBox(height: 16,),

                      TextFormField(
                        validator: (value){
                          if(value==null|| value.isEmpty){
                            return " Please Enter your last name";
                          }
                          return null;
                        },
                        controller: _lastNameEditingController,
                        decoration: const InputDecoration(
                          hintText: "Enter your last name",
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),

                      const SizedBox(height: 16,),

                      TextFormField(
                        validator: (value){
                          if(value==null|| value.isEmpty){
                            return " Please Enter your Mobile";
                          }
                          return null;
                        },
                        controller: _mobileEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: "Enter your Mobile",
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),

                      const SizedBox(height: 16,),

                      TextFormField(
                        controller: _passwordEditingController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Enter your password",
                          prefixIcon: Icon(Icons.lock_clock_outlined),
                        ),
                      ),

                      const SizedBox(height: 16,),

                      SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: !updateProfileInProgress,
                          replacement: const Center(child: CircularProgressIndicator(),),
                          child: ElevatedButton(
                              onPressed: (){
                                if(_formKey.currentState!.validate()){
                                  updateProfile();

                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context)=>
                                  //     const BottomNabBarScreen()));
                                }
                              },
                              child: const Icon(Icons.arrow_circle_right_outlined,size: 30,)
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }

  void selectedImage(){
    picker.pickImage(source: ImageSource.gallery).then((xFile){
      if(xFile != null ){
        imageFile = xFile;
        if(mounted){
          setState(() {});
        }
      }
    });
  }

}
