import 'package:get/get.dart';

import '../data/Utils/urls.dart';
import '../data/service/network_coller.dart';
import '../data/service/network_response.dart';

class OtpVerifyController extends GetxController{


  bool _otpVerificationInProgress = false;
  bool get otpVerificationInProgress => _otpVerificationInProgress;


  Future<bool> otpVerification(String email,String otp) async{

    _otpVerificationInProgress = true;
   update();

    final NetworkResponse response = await NetWorkCaller().getRequest(
        Urls.otpVerification(email, otp));

    _otpVerificationInProgress = false;
    update();

    if(response.isSuccess){

      return true;
    }else{
     return false;
    }
  }



}