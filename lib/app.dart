import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/state_management/cancel%20_task_controller.dart';
import 'package:task_manager_project/state_management/completed_task_controller.dart';
import 'package:task_manager_project/state_management/create_task_controller.dart';
import 'package:task_manager_project/state_management/delete_task_Controller.dart';
import 'package:task_manager_project/state_management/email_verify_controller.dart';
import 'package:task_manager_project/state_management/inProgress_task_controller.dart';
import 'package:task_manager_project/state_management/login_controller.dart';
import 'package:task_manager_project/state_management/new_task_controller.dart';
import 'package:task_manager_project/state_management/otp_verify_controller.dart';
import 'package:task_manager_project/state_management/regestration_controller.dart';
import 'package:task_manager_project/state_management/reset_password_controller.dart';
import 'package:task_manager_project/state_management/summery_count_controller.dart';
import 'package:task_manager_project/state_management/update_profile_controller.dart';
import 'package:task_manager_project/state_management/update_task_status_controller.dart';
import 'package:task_manager_project/ui/screen/splash_screen.dart';

class MyApp extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        navigatorKey: MyApp.globalKey,
        debugShowCheckedModeBanner: false,
        initialBinding: ControllerBinding(),
        home: const SplashScreen(),
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.teal,
          inputDecorationTheme: InputDecorationTheme(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                elevation: 3,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.deepOrange,
          inputDecorationTheme: InputDecorationTheme(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                elevation: 3,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
        themeMode: ThemeMode.light);
  }
}
class ControllerBinding extends Bindings {
  @override
  void dependencies() {
   Get.put<LoginController>(LoginController());
   Get.put<SummeryCountController>(SummeryCountController());
   Get.put<RegistrationController>(RegistrationController());
   Get.put<EmailVerifyController>(EmailVerifyController());
   Get.put<OtpVerifyController>(OtpVerifyController());
   Get.put<ResetPasswordController>(ResetPasswordController());
   Get.put<NewTaskController>(NewTaskController());
   Get.put<UpdateProfileController>(UpdateProfileController());
   Get.put<CreateTaskController>(CreateTaskController());
   Get.put<DeleteTaskController>(DeleteTaskController());
   Get.put<UpdateTaskStatusController>(UpdateTaskStatusController());
   Get.put<CompletedTaskController>(CompletedTaskController());
   Get.put<CancelTaskController>(CancelTaskController());
   Get.put<InProgressTaskController>(InProgressTaskController());
  }
}
