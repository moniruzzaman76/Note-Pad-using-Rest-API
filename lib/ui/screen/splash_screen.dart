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
                    const SizedBox(height: 100,),
                    const Text("Welcome To",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Colors.green
                    ),),
                    const SizedBox(height: 15,),
                    const Icon(Icons.android_outlined,color: Colors.green,size: 70,),
                    const SizedBox(height: 15,),
                    const Text("Node Pad",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.blue,
                      letterSpacing: 4,
                    ),),
                    const SizedBox(height: 50,),
                    Image.asset(
                      AssetUtils.splashLogo,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              )
          )

        ],
      ),
    ));
  }
}
