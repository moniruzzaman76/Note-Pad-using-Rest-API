import 'package:get/get.dart';
import '../data/Utils/urls.dart';
import '../data/model/auth_utility.dart';
import '../data/model/login_model.dart';
import '../data/service/network_coller.dart';
import '../data/service/network_response.dart';

class LoginController extends GetxController{

  bool _singInProgress = false;
  bool get singInProgress => _singInProgress;


  Future<bool>userSingIn(String email,String password)async{

    _singInProgress = true;
    update();

    Map<String,dynamic>requestBody = {
      "email":email,
      "password":password,
    };

    final NetworkResponse response = await NetWorkCaller().postRequest(
        Urls.login,requestBody,isLogin: true);

    _singInProgress = false;
    update();

    if(response.isSuccess){

      LoginModel model = LoginModel.fromJson(response.body!);
      await AuthUtility.saveUserInfo(model);
      return true;

    }else{
      _singInProgress = false;
      update();
      return false;
    }
  }


}