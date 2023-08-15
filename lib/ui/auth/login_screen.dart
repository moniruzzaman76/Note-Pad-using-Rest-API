import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/auth/registration_screen.dart';
import '../../data/Utils/urls.dart';
import '../../data/model/auth_utility.dart';
import '../../data/model/login_model.dart';
import '../../data/service/network_coller.dart';
import '../../data/service/network_response.dart';
import '../../widgets/background_images.dart';
import '../screen/bottom_nab_bar_screen.dart';
import 'email_verification_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();

   final _formKey = GlobalKey<FormState>();

   bool isHiddenPassword = true;

   bool _singInProgress = false;


   Future<void>userSingIn()async{

     _singInProgress = true;
     if(mounted){
       setState(() {});
     }

     Map<String,dynamic>requestBody = {
       "email":_emailEditingController.text.trim(),
       "password":_passwordEditingController.text,
     };

     final NetworkResponse response = await NetWorkCaller().postRequest(
         Urls.login,requestBody,isLogin: true);

     _singInProgress = false;
     if(mounted){
       setState(() {});
     }

     if(response.isSuccess){
       _emailEditingController.clear();
       _passwordEditingController.clear();

       LoginModel model = LoginModel.fromJson(response.body!);
       await AuthUtility.saveUserInfo(model);

       if(mounted){
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
             builder: (context)=>const BottomNabBarScreen()),
                 (route) => false);

         ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(backgroundColor: Colors.green,content: Text("Login Successful!")));
       }
     }else{
       if(mounted){
         ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(backgroundColor: Colors.red, content: Text("Login fail!")));
       }
       _singInProgress = false;
       if(mounted){
         setState(() {});
       }
     }
   }

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
                      const SizedBox(height: 100),
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

                      SizedBox(
                         width: double.infinity,
                        child: Visibility(
                          visible: _singInProgress == false,
                          replacement: const Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                              onPressed: (){
                                if(_formKey.currentState!.validate()){

                                  userSingIn();

                                }
                              },
                              child: const Icon(Icons.arrow_circle_right_outlined,size: 30,)
                          ),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      Row(
                        children: [
                          const SizedBox(width: 230,),
                          TextButton(
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context)=>const EmailVerificationScreen()));
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
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>const RegistrationScreen()));
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




