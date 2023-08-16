import 'package:get/get.dart';
import '../data/Utils/urls.dart';
import '../data/service/network_coller.dart';
import '../data/service/network_response.dart';

class RegistrationController extends GetxController{

  bool _signUpInProgress = false;
  bool get signUpInProgress => _signUpInProgress;
  Future<bool>userSingUp(String email,String firstName,String lastName,String mobile,String password,String photo)async{

    _signUpInProgress = true;
    update();

    final NetworkResponse response =
    await NetWorkCaller().postRequest(Urls.registration,<String,dynamic>{
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": photo,
    });

    _signUpInProgress = false;
    update();

    if(response.isSuccess){
        return true;

      } else{
        _signUpInProgress = false;
       update();
       return false;

        }
      }
    }


