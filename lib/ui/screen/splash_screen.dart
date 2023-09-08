import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/auth_utility.dart';
import '../../widgets/background_images.dart';
import '../assets_utils/assets_utils.dart';
import 'bottom_nab_bar_screen.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    navigatorToLogin();
  }

  Future<void> navigatorToLogin() async {
    Future.delayed(const Duration(seconds: 3)).then((value) async{
       final bool isLoggedIn = await AuthUtility.checkIfUserLoggedIn();

       if(mounted){
         Get.offAll( isLoggedIn ?  const BottomNabBarScreen() :  const LoginScreen());
       }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          ScreenBackGround(
              child:  Center(
                child: Column(
                  children: [
                    const SizedBox(height: 140,),
                    const Text("Welcome To",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Colors.teal
                    ),),
                    const SizedBox(height: 15,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Icon(Icons.android_outlined,color: Colors.green,size: 50,),
                         SizedBox(width:8,),
                         Icon(Icons.apple_outlined,color: Colors.grey,size: 50,),
                        // SizedBox(width:8,),
                        // Icon(Icons.web_outlined,color: Colors.blue,size: 50,),
                      ],
                    ),
                    // const SizedBox(height: 15,),
                    // const Text("Node Pad",style: TextStyle(
                    //   fontWeight: FontWeight.bold,
                    //   fontSize: 50,
                    //   color: Colors.blue,
                    //   letterSpacing: 4,
                    // ),),
                    const SizedBox(height: 35,),
                    Image.asset(
                      // AssetUtils.splashLogo,
                      // AssetUtils.notesLogo,
                      AssetUtils.notesIcon,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 220,),
                    const Text("Version 1.2.0",style: TextStyle(color: Colors.grey,fontSize: 18),)
                  ],
                ),
              )
          )

        ],
      ),
    ));
  }
}
