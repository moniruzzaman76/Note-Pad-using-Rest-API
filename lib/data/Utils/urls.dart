class Urls{
  Urls._();
  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static  String registration = "$_baseUrl/registration";
  static String login = "$_baseUrl/login";
  static String createTask = "$_baseUrl/createTask";
  static String taskStatusCount = "$_baseUrl/taskStatusCount";
  static String newTaskList = "$_baseUrl/listTaskByStatus/New";
  static String completedTaskList = "$_baseUrl/listTaskByStatus/Completed";
  static String inProgressTaskList = "$_baseUrl/listTaskByStatus/Progress";
  static String cancelledTaskList = "$_baseUrl/listTaskByStatus/Cancelled";
  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
  static String profileUpdate = "$_baseUrl/profileUpdate";
  static String emailVerification(String email) => "$_baseUrl/RecoverVerifyEmail/$email";
  static String otpVerification(String email,String otp) => "$_baseUrl/RecoverVerifyOTP/$email/$otp";
  static String resetPassword = "$_baseUrl/RecoverResetPass";
  static String updateTask(String id, String status) => '$_baseUrl/updateTaskStatus/$id/$status';
}