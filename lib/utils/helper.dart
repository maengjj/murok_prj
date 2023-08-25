import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:murok_prj/models/dashboard_res.dart';
import 'package:murok_prj/models/login_response.dart';
import 'package:murok_prj/models/loginuser.dart';
import 'package:murok_prj/models/sign_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'dart:convert';


Future<bool> loginUserWithEmail(String email, String pass) async {
  if (email != '' && pass != '') {
    // var url = Uri.http('10.0.2.2:5000', 'user/login');
    var url = Uri.parse('http://15.164.103.233:3000/app/login');
    var user = LoginUser(email: email, passwrd: pass);
    Map<String, String> headers = {'Content-type': 'application/json'};
    var response = await http.post(url, headers: headers, body: user.toJson());
    print(response.body);


    String responseBody = response.body;
    Map<String, dynamic> responseMap = json.decode(responseBody);
    bool isSuccess = responseMap['isSuccess'];
    String failmessage = responseMap['message'];
    if (isSuccess ==  false) {
      Get.showSnackbar(GetSnackBar(
        title: "로그인 실패",
        message: failmessage,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      ));
    }


    var data = LoginResponse.fromJson(response.body);
    print(data);
    Get.showSnackbar(GetSnackBar(
      title: "로그인 성공",
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
    message: "이메일과 비밀번호를 모두 입력해주세요.",
  ));

  return false;
}





Future<bool> registerUser(String uemail, String pass, String cpass, String name, String nickname, String phone) async {
  if (uemail != '' && pass != '' && name != '' && nickname != '' && phone != '' && cpass != '') {
    if (pass == cpass) {
      // var url = Uri.http('http://15.164.103.233:3000', 'app/users');
      var url = Uri.parse('http://15.164.103.233:3000/app/users');
      User user = User(email: uemail,
          passwrd: pass,
          name: name,
          nickname: nickname,
          phoneNum: phone);
      Map<String, String> headers = {'Content-type': 'application/json'};
      var response = await http.post(
          url, headers: headers, body: user.toJson());
      print(response.body);
      var data = SignResponse.fromJson(response.body);

      // Get.showSnackbar(GetSnackBar(
      //   title: "회원가입 성공",
      //   message: data.getMsg,
      //   snackPosition: SnackPosition.TOP,
      //   duration: const Duration(seconds: 5),
      // )
      // );
      if (response.statusCode == 200) {
        if (data.getStatus == true) {
          Get.showSnackbar(GetSnackBar(
            title: "회원가입 성공",
            message: data.getMsg,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          )
          );
          return true;
        }
        else {
          Get.showSnackbar(GetSnackBar(
            title: "회원가입 실패",
            message: data.getMsg,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          )
          );
          return false;
        }
      }
      return false;
    }
    Get.showSnackbar(const GetSnackBar(
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
      title: "회원가입 실패",
      message: "비밀번호를 확인해주세요.",
    ));
    return false;
  }
  Get.showSnackbar(const GetSnackBar(
    duration: Duration(seconds: 2),
    snackPosition: SnackPosition.TOP,
    title: "회원가입 실패",
    message: "모든 정보를 입력해주세요.",
  ));
  return false;
}

// Future getUserProfile() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final String? token = prefs.getString('token');
//
//   if (token != null) {
//     // var url = Uri.http('10.0.2.2:5000', 'user/dashboard');
//     var url = Uri.parse('http://15.164.103.233:3000/app/users');
//     Map<String, String> headers = {
//       'Content-type': 'application/json',
//       'Authorization': 'bearer $token'
//     };
//
//     var response = await http.post(url, headers: headers);
//     var data = DashboardRes.fromJson(response.body);
//     print('response.body');
//     print(response.body);
//
//     return data;
//   }
// }


Future<DashboardRes> getUserProfile() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');
  print('token');
  print(token);

  if (token != null) {
    var url = Uri.parse('http://15.164.103.233:3000/app/users/read');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'x-access-token': '$token'
    };

    var response = await http.get(url, headers: headers);  // GET 요청으로 변경
    print('response');
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = DashboardRes.fromJson(response.body);
      print('response.body');
      print(response.body);
      print(data);
      return data;
    } else {
      throw Exception('Failed to fetch user profile');
    }
  } else {
    throw Exception('Token not available');
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
