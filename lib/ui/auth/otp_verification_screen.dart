import 'package:flutter/material.dart';
import '../../data/Utils/urls.dart';
import '../../data/service/network_coller.dart';
import '../../data/service/network_response.dart';
import '../../widgets/background_images.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'Reset_password_screen.dart';
import 'login_screen.dart';

class PinVerificationScreen extends StatefulWidget {
  final String email;
  const PinVerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {

  final TextEditingController _otpVerifyController= TextEditingController();


  final _formKey = GlobalKey<FormState>();

  bool otpVerificationInProgress = false;


  Future<void> otpVerification() async{

    otpVerificationInProgress = true;
    if(mounted){
      setState(() {});
    }

    final NetworkResponse response = await NetWorkCaller().getRequest(
        Urls.otpVerification(widget.email, _otpVerifyController.text));

    otpVerificationInProgress = false;
    if(mounted){
      setState(() {});
    }

    if(response.isSuccess){
      if(mounted){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=> ResetPasswordScreen(email:widget.email, otp:_otpVerifyController.text )));

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green, content: Text("otp verify successfully")));
      }
    }else{
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red, content: Text(" otp verify failed!")));
      }

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
       child:  SafeArea(
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
                       Text("Pin Verification",
                         style: Theme.of(context).textTheme.titleLarge,),

                       const SizedBox(height:6,),

                       Text("A 6 digit verification pin will sent on your email address",
                         style: Theme.of(context).textTheme.bodyMedium,),

                       const SizedBox(height: 20,),

                       PinCodeTextField(
                         validator: (value){
                           if(value==null|| value.isEmpty){
                             return " Please Enter your email";
                           }
                           return null;
                         },
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         appContext: context,
                         length: 6,
                         obscureText: false,
                         cursorColor: Colors.green,
                         animationType: AnimationType.fade,
                         keyboardType: TextInputType.phone,
                         pinTheme: PinTheme(
                           shape: PinCodeFieldShape.box,
                           borderRadius: BorderRadius.circular(5),
                           fieldHeight: 50,
                           fieldWidth: 40,
                           activeFillColor: Colors.white,
                           activeColor: Colors.white,
                           inactiveColor: Colors.red,
                           selectedColor: Colors.green,
                           selectedFillColor: Colors.white,
                           inactiveFillColor: Colors.white,
                         ),
                         animationDuration: const Duration(milliseconds: 300),
                         backgroundColor: Colors.blue.shade50,
                         enableActiveFill: true,
                         controller: _otpVerifyController,
                         onCompleted: (v) {
                         },
                         onChanged: (value) {
                           print(value);
                           setState(() {});
                         },
                         beforeTextPaste: (text) {
                           print("Allowing to paste $text");
                           return true;
                         },
                       ),

                       const SizedBox(height: 20,),

                       SizedBox(
                         height: 40,
                         width: double.infinity,
                         child: Visibility(
                           visible: !otpVerificationInProgress,
                           replacement: const Center(child: CircularProgressIndicator(),),
                           child: ElevatedButton(
                               onPressed: (){
                                 if(_formKey.currentState!.validate()){
                                   otpVerification();
                                 }
                               },
                               child: const Text("Verify"),
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
                             Navigator.pushAndRemoveUntil(context,
                                 MaterialPageRoute(builder: (context)=>const LoginScreen()),
                                     (route) => false);
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
      ),
    );
  }
}


