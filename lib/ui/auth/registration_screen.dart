import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/state_management/regestration_controller.dart';
import '../../widgets/background_images.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final TextEditingController _firstNameEditingController = TextEditingController();
  final TextEditingController _lastNameEditingController = TextEditingController();
  final TextEditingController _mobileEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackGround(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 70),
                      Text("Create Account",
                        style: Theme.of(context).textTheme.titleLarge,),
                      const SizedBox(height: 10,),
                      const Text("Sing up to Continue",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )),

                      const SizedBox(height: 20,),

                      TextFormField(
                        validator: (value){
                          if(value==null || value.isEmpty){
                            return "Please Enter Your Email Address";
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
                          if(value==null || value.isEmpty){
                            return "Enter your firs Name";
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
                          if(value==null || value.isEmpty ){
                            return "Enter your last name";
                          }
                          return null;
                        },
                        controller: _lastNameEditingController,
                        decoration: const InputDecoration(
                          hintText: "Enter your last name",
                          prefixIcon: Icon(Icons.person_2_outlined),
                        ),
                      ),

                      const SizedBox(height: 16,),

                      TextFormField(
                        maxLength: 11,
                        validator: (value){
                          if(value==null || value.isEmpty || value.length > 11){
                            return "Enter your Mobile";
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

                      const SizedBox(height: 12,),

                      TextFormField(
                        validator: (value){
                          if(value==null || value.isEmpty){
                            // || value.length <= 5
                            return "Enter your password";
                          }
                          return null;
                        },
                        controller: _passwordEditingController,
                        obscureText: _isHiddenPassword,
                        decoration: InputDecoration(
                            hintText: "Enter your password",
                            prefixIcon: const Icon(Icons.lock_clock_outlined),
                            suffixIcon: InkWell(
                              onTap: (){
                                _isHiddenPassword =! _isHiddenPassword;
                                setState(() {});
                              },
                              child: _isHiddenPassword == true ?
                              const Icon(Icons.visibility_off):const Icon(Icons.visibility),
                            )
                        ),
                      ),

                      const SizedBox(height: 16,),

                      GetBuilder<RegistrationController>(
                        builder: (registrationController) {
                          return SizedBox(
                            width: double.infinity,
                            child: Visibility(
                              visible: registrationController.signUpInProgress == false,
                              replacement: const Center(child: CircularProgressIndicator(),),
                              child: ElevatedButton(
                                  onPressed: (){
                                    if(_formKey.currentState!.validate()){
                                      registrationController.userSingUp(
                                          _emailEditingController.text.trim(),
                                          _firstNameEditingController.text.trim(),
                                          _lastNameEditingController.text.trim(),
                                          _mobileEditingController.text.trim(),
                                          _passwordEditingController.text,
                                           "",
                                      ).then((result) {
                                        if(result == true){
                                          _emailEditingController.clear();
                                        _firstNameEditingController.clear();
                                        _lastNameEditingController.clear();
                                        _mobileEditingController.clear();
                                        _passwordEditingController.clear();
                                        Get.snackbar(
                                            "Success!", "Registration Successfully done",
                                            backgroundColor: Colors.green,
                                            colorText: Colors.white
                                        );
                                        Get.to(const LoginScreen());
                                        }else{
                                          Get.snackbar(
                                              "failed!", "Registration failed!.try again",
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white
                                          );
                                        }

                                      });
                                    }
                                  },
                                  child: const Icon(Icons.arrow_circle_right_outlined,size: 30,)
                              ),
                            ),
                          );
                        }
                      ),

                      const SizedBox(height: 16,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Have account?",style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5
                          ),),

                          TextButton(onPressed: (){
                            Get.to(const LoginScreen());
                          },
                            child: const Text("Sing In",style: TextStyle(
                              fontSize: 18,
                            ),),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }
}




