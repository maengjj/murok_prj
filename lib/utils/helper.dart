import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:murok_prj/models/dashboard_res.dart';
import 'package:murok_prj/models/login_response.dart';
import 'package:murok_prj/models/loginuser.dart';
import 'package:murok_prj/models/sign_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

Future<bool> loginUserWithEmail(String email, String pass) async {
  if (email != '' && pass != '') {
    var url = Uri.http('10.0.2.2:5000', 'user/login');
    var user = LoginUser(email: email, password: pass);
    Map<String, String> headers = {'Content-type': 'application/json'};
    var response = await http.post(url, headers: headers, body: user.toJson());
    var data = LoginResponse.fromJson(response.body);
    Get.showSnackbar(GetSnackBar(
      title: "Login",
      message: data.getMsg,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    ));
    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data.token);
      return true;
    }
    return false;
  }
  Get.showSnackbar(const GetSnackBar(
    duration: Duration(seconds: 2),
    snackPosition: SnackPosition.TOP,
    title: "로그인",
    message: "이메일과 비밀번호를 확인해주세요.",
  ));

  return false;
}

Future<bool> registerUser(String uemail, String name, String nickname, String pass, String cpass, String phone) async {
  if (uemail != '' && pass != '' && cpass != '' && name != '' && nickname != '' && phone != '') {
    var url = Uri.http('10.0.2.2:5000', 'user/register');
    User user = User(email: uemail, password: pass, cpassword: cpass, name: name, nickname: nickname, phone: phone);
    Map<String, String> headers = {'Content-type': 'application/json'};
    var response = await http.post(url, headers: headers, body: user.toJson());
    var data = SignResponse.fromJson(response.body);
    Get.showSnackbar(GetSnackBar(
      title: "Signup",
      message: data.getMsg,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    ));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
  Get.showSnackbar(const GetSnackBar(
    duration: Duration(seconds: 2),
    snackPosition: SnackPosition.TOP,
    title: "회원가입",
    message: "모든 정보를 입력해주세요.",
  ));

  return false;
}

Future getUserProfile() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');
  if (token != null) {
    var url = Uri.http('10.0.2.2:5000', 'user/dashboard');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'bearer $token'
    };
    var response = await http.post(url, headers: headers);
    var data = DashboardRes.fromJson(response.body);

    return data;
  }
}

Future<bool> userProfileAvailble() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');
  if (token != null) {
    return true;
  }
  return false;
}
