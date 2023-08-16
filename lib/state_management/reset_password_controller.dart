import 'package:get/get.dart';
import '../data/Utils/urls.dart';
import '../data/service/network_coller.dart';
import '../data/service/network_response.dart';

class ResetPasswordController extends GetxController{

  bool _resetPasswordInProgress = false;
  bool get resetPasswordInProgress => _resetPasswordInProgress;


  Future<bool> resetPassword(String email,String otp,String password) async{

    _resetPasswordInProgress = true;
    update();

    final Map<String, dynamic> requestBody = {
      "email":email,
      "OTP":otp,
      "password":password,
    };

    final NetworkResponse response = await NetWorkCaller().postRequest(Urls.resetPassword, requestBody);
    _resetPasswordInProgress = false;
    update();

    if(response.isSuccess){
      return true;
    }else{
      return false;
    }
  }
}