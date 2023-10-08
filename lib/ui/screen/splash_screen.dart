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
              child:  Column(
                children: [
                   const Spacer(),
                  Center(
                    child: Image.asset(
                      AssetUtils.splashIcon,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Spacer(),
                  const Text("Version 1.2.0",style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 15,),
                  const Text("Developed by Monir",style: TextStyle(color: Colors.grey,fontSize: 15),),
                  const SizedBox(height: 20,),
                ],
              )
          )

        ],
      ),
    ));
  }
}
