import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../data/Utils/urls.dart';
import '../data/service/network_coller.dart';
import '../data/service/network_response.dart';

class UpdateProfileController extends GetxController{

  bool _updateProfileInProgress = false;
  bool get updateProfileInProgress => _updateProfileInProgress;

  Future<bool>updateProfile(String firstName,String lastName,String mobile,String photo,String password) async{
    _updateProfileInProgress = true;
    update();
    final Map<String,dynamic> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "photo": photo,
    };
    if(password.isNotEmpty){
      requestBody["password"] = password;
    }
    final NetworkResponse response = await NetWorkCaller().postRequest(Urls.profileUpdate, requestBody);
    _updateProfileInProgress = false;
    update();
    if(response.isSuccess){

      Get.snackbar("Profile!", " Update successfully done",colorText: CupertinoColors.activeGreen);
      return true;
    }else{
      Get.snackbar(
          "Profile", "Update failed!.try again",
          backgroundColor: CupertinoColors.systemGrey6,
          colorText: CupertinoColors.systemGreen
      );
      return false;
    }
  }

}