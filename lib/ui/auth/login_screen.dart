import 'package:flutter/material.dart';
import 'package:task_manager_project/state_management/login_controller.dart';
import 'package:task_manager_project/ui/auth/registration_screen.dart';
import '../../widgets/background_images.dart';
import '../screen/bottom_nab_bar_screen.dart';
import 'email_verification_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // if do not use ControllerBinding and fine.then use this process
  // final LoginController loginController = Get.put(LoginController());

  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();

   final _formKey = GlobalKey<FormState>();

   bool isHiddenPassword = true;

   //LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackGround(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key:_formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      const Icon(Icons.lock,size: 150,color: Colors.grey,),
                      const SizedBox(height: 30),
                       Text("Get Started with",
                      style: Theme.of(context).textTheme.titleLarge,),

                      const SizedBox(height: 30,),

                      TextFormField(
                        validator: (value){
                          if(value==null || value.isEmpty){
                            return "Enter Your Email Address";
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

                      const SizedBox(height: 20,),

                      TextFormField(
                        validator: (value){
                          if(value==null || value.isEmpty){
                            return "please Enter your password";
                          }
                          return null;
                        },
                        controller: _passwordEditingController,
                        obscureText: isHiddenPassword,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          prefixIcon: const Icon(Icons.lock_clock_outlined),
                          suffixIcon: InkWell(
                            onTap: (){
                               isHiddenPassword =! isHiddenPassword;
                              setState(() {});
                            },
                              child: isHiddenPassword == true ?
                              const Icon(Icons.visibility_off):const Icon(Icons.visibility),
                          )
                        ),
                      ),

                      const SizedBox(height: 20,),

                      GetBuilder<LoginController>(
                        builder: (loginController) {
                          return SizedBox(
                             width: double.infinity,
                            child: Visibility(
                              visible: loginController.singInProgress == false,
                              replacement: const Center(child: CircularProgressIndicator()),
                              child: ElevatedButton(
                                  onPressed: (){
                                    if(_formKey.currentState!.validate()){
                                      loginController.userSingIn(
                                          _emailEditingController.text.trim(),
                                          _passwordEditingController.text
                                      ).then((result) {
                                        if(result == true){
                                          Get.offAll(const BottomNabBarScreen());
                                        }else{
                                          Get.snackbar(
                                            "Failed!", "Login failed!.Please try again",
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,

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

                      const SizedBox(height: 20,),

                      Row(
                        children: [
                          const SizedBox(width: 215,),
                          TextButton(
                            onPressed: (){
                              Get.to(const EmailVerificationScreen());
                            },
                            child: const Text("Forgot Password ?",style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15,
                          ),),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                               const Text("Don't have account?",style: TextStyle(
                                fontSize: 18,
                               fontWeight: FontWeight.w500,
                                 letterSpacing: 0.5
                              ),),

                          TextButton(onPressed: (){
                           Get.to(const RegistrationScreen());

                          },
                              child: const Text("Sing up",style: TextStyle(
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




