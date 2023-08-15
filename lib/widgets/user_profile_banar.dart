import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/model/auth_utility.dart';
import '../ui/assets_utils/assets_utils.dart';
import '../ui/auth/login_screen.dart';

class UserProfileBanner extends StatefulWidget {
  const UserProfileBanner({
    super.key,
  });

  @override
  State<UserProfileBanner> createState() => _UserProfileBannerState();
}

class _UserProfileBannerState extends State<UserProfileBanner> {
  @override
  Widget build(BuildContext context) {
    return  ListTile(
       tileColor: Colors.green,
      // using CachedNetworkImage package
      leading: CachedNetworkImage(
        placeholder: (context, url) => const CircularProgressIndicator(),
        imageUrl: AuthUtility.userInfo.data?.photo ?? "",
        errorWidget: (context, url, error) => CircleAvatar(
          backgroundColor: Colors.white,
          radius: 22,
          child: Image.asset(AssetUtils.profilePic,fit: BoxFit.cover,),
        ),
      ),

      title: Text(
        "${AuthUtility.userInfo.data?.firstName ?? ""} ${AuthUtility.userInfo.data?.lastName ?? ""}",
        style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
            fontWeight: FontWeight.w500
      ),),
      subtitle:  Text(AuthUtility.userInfo.data?.email ?? "",style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        letterSpacing: .5
      ),),
      trailing: IconButton(onPressed: () async {

        logOutAlterDialog();

      }, icon: const Icon(Icons.login_outlined,color: Colors.white,)),
    );
  }

  Future logOutAlterDialog(){
    return showDialog(
        context: (context),
        builder: (context){
          return AlertDialog(
            title: const Center(
                child: Text("Alert!",style: TextStyle(
                    color:Colors.grey,
                    fontWeight: FontWeight.bold),
                )
            ),
            content: const Text("Are you sure want to Log Out?",style:TextStyle(
              fontSize: 20,
            ),),
            actions: [
              Row(
                children: [
                  TextButton(
                      onPressed: () async{

                        await AuthUtility.clearUserInfo();

                        if(mounted){
                         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                             builder: (context)=>const LoginScreen()),
                                 (route) => false);
                        }
                      }, child: const Text("Yes",style: TextStyle(
                      fontSize: 20,
                      color: Colors.green
                  ),)),
                  const Spacer(),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: const Text("NO",style: TextStyle(
                    fontSize: 20,
                    color: Colors.red
                  ),)),

                ],
              )
            ],
          );
        }
    );
  }

}