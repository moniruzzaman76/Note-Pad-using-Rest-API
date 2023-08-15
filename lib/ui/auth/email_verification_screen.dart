import 'package:flutter/material.dart';
import '../../data/Utils/urls.dart';
import '../../data/service/network_coller.dart';
import '../../data/service/network_response.dart';
import '../../widgets/background_images.dart';
import 'otp_verification_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  final TextEditingController _emailEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

   bool emailVerificationInProgress = false;


  Future<void> emailVerification() async{
    emailVerificationInProgress = true;
    if(mounted){
      setState(() {});
    }
    final NetworkResponse response = await NetWorkCaller().getRequest(
        Urls.emailVerification(_emailEditingController.text.trim()));
    emailVerificationInProgress = false;
    if(mounted){
      setState(() {});
    }
     if(response.isSuccess){
       if(mounted){
         Navigator.push(context, MaterialPageRoute(
             builder: (context)=> PinVerificationScreen(email: _emailEditingController.text,)));

         if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
               backgroundColor: Colors.green, content: Text(" Email verify successful!")));
         }
       }

     }else{
       if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
             backgroundColor: Colors.red, content: Text(" Email verify failed!")));
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
                      Text("Your Email Address",
                        style: Theme.of(context).textTheme.titleLarge,),

                      const SizedBox(height:6,),

                      Text("A 6 digit verification pin will sent on your email address",
                        style: Theme.of(context).textTheme.bodyMedium,),
                      const SizedBox(height: 20,),

                      TextFormField(
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

                      const SizedBox(height: 20,),

                      SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: !emailVerificationInProgress,
                          replacement: const Center(child: CircularProgressIndicator(),),
                          child: ElevatedButton(
                              onPressed: (){
                                if(_formKey.currentState!.validate()){
                                  emailVerification();
                                }
                              },
                              child: const Icon(Icons.arrow_circle_right_outlined,size: 30,)
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

