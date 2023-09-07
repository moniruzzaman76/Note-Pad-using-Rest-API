import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/state_management/reset_password_controller.dart';
import '../../widgets/background_images.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email, otp;
  const ResetPasswordScreen({Key? key, required this.email, required this.otp}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final TextEditingController _passwordEditingController = TextEditingController();
  final TextEditingController _confirmPasswordEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();



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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100,),
                        Text("Set Password",
                          style: Theme.of(context).textTheme.titleLarge,),

                        const SizedBox(height: 16,),

                        TextFormField(
                          validator: (String ? value){
                            if(value?.isEmpty ?? true){
                              return "Enter your password";
                            }
                            return null;
                          },
                          controller: _passwordEditingController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "password",
                            prefixIcon: Icon(Icons.lock_clock_outlined),
                          ),
                        ),

                        const SizedBox(height: 16,),

                        TextFormField(
                          validator: (String ? value){
                            if(value?.isEmpty ?? true){
                              return "Enter confirm password";
                            }else if(value != _passwordEditingController.text){
                              return "Confirm password does n\'t match";
                            }
                            return null;
                          },
                          controller: _confirmPasswordEditingController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "Confirm password",
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),

                        const SizedBox(height: 20,),

                        GetBuilder<ResetPasswordController>(
                          builder: (resetPasswordController) {
                            return SizedBox(
                              width: double.infinity,
                              child: Visibility(
                                visible: !resetPasswordController.resetPasswordInProgress,
                                replacement: const Center(child: CircularProgressIndicator(),),
                                child: ElevatedButton(
                                    onPressed: (){
                                      if(!_formKey.currentState!.validate()){
                                        return;
                                      }
                                     resetPasswordController.resetPassword(
                                         widget.email,
                                         widget.otp,
                                         _passwordEditingController.text
                                     ).then((reset){
                                       if(reset == true){
                                         Get.to(const LoginScreen());
                                         Get.snackbar(
                                             "Success!", "Reset Password Successfully done",
                                           backgroundColor: Colors.green,
                                           colorText: Colors.white
                                         );
                                       }else{
                                         Get.snackbar(
                                             "Failed!", "Reset Password failed.Try again",
                                             backgroundColor: Colors.red,
                                             colorText: Colors.white
                                         );
                                       }
                                     });
                                    },
                                    child: const Text("Confirm")
                                ),
                              ),
                            );
                          }
                        ),

                        const SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Have account?",style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5
                            ),),

                            TextButton(onPressed: (){
                              Navigator.pop(context);
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
        )
    );
  }
}

