import 'package:flutter/material.dart';
import '../../data/Utils/urls.dart';
import '../../data/service/network_coller.dart';
import '../../data/service/network_response.dart';
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


  bool _resetPasswordInProgress = false;


  Future<void> resetPassword() async{

    _resetPasswordInProgress = true;
    if(mounted){
      setState(() {});
    }

    final Map<String, dynamic> requestBody = {
      "email":widget.email,
      "OTP":widget.otp,
      "password":_passwordEditingController.text,
    };

    final NetworkResponse response = await NetWorkCaller().postRequest(Urls.resetPassword, requestBody);


    _resetPasswordInProgress = false;
    if(mounted){
      setState(() {});
    }

    if(response.isSuccess){
      if(mounted){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=> const LoginScreen()));

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green, content: Text("Reset Password successfully!")));

      }
    }else{
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red, content: Text(" Reset Password failed!")));
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
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100,),
                        Text("Set Password",
                          style: Theme.of(context).textTheme.titleLarge,),

                        const SizedBox(height:6,),

                        Text("A 6 digit verification pin will sent on your email address",
                          style: Theme.of(context).textTheme.bodyMedium,),

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

                        SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: !_resetPasswordInProgress,
                            replacement: const Center(child: CircularProgressIndicator(),),
                            child: ElevatedButton(
                                onPressed: (){
                                  if(!_formKey.currentState!.validate()){
                                    return;
                                  }
                                  resetPassword();
                                },
                                child: const Text("Confirm")
                            ),
                          ),
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

