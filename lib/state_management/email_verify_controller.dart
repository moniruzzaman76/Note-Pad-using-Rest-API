import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../data/Utils/urls.dart';
import '../data/service/network_coller.dart';
import '../data/service/network_response.dart';

class EmailVerifyController extends GetxController{

  bool _emailVerifyInProgress = false;
  bool get emailVerifyInProgress=> _emailVerifyInProgress;

  Future<void> emailVerification(String email) async{
    _emailVerifyInProgress = true;
    update();
    final NetworkResponse response = await NetWorkCaller().getRequest(
        Urls.emailVerification(email));

    _emailVerifyInProgress = false;
     update();

    if(response.isSuccess){
      Get.snackbar(
          "Successful", "Email verify successfully done!",
          backgroundColor: CupertinoColors.activeGreen,
          colorText: CupertinoColors.white
      );
      //return true;
      }else{
      Get.snackbar(
          "failed", "Email verify failed!.try again",
          backgroundColor: CupertinoColors.destructiveRed,
          colorText: CupertinoColors.white
      );
      //return false;
    }
    }
  }
