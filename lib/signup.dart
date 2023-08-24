import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:murok_prj/utils/helper.dart';

import 'intro_page.dart';
import 'login.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    // var cPassController = TextEditingController();
    var nameController = TextEditingController();
    var nicknameController = TextEditingController();
    var phoneController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF06C09F),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF06C09F),
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => const IntroPage());
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        // title: const Text(
        //   "Sign up",
        //   style: TextStyle(
        //       fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        // ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          // height: MediaQuery.of(context).size.height - 50,
          // width: double.infinity,
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 15), // 원하는 만큼의 간격 설정
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height / 3,
                  //   child: const Image(
                  //     colorBlendMode: BlendMode.overlay,
                  //     image: AssetImage('assets/background.png'),
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.centerLeft, // 왼쪽 정렬
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0), // 텍스트와 왼쪽 간격 설정
                      child: const Text(
                        "회원가입",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
              Column(
                children: <Widget>[
                  makeInput(label: "이름", controller: nameController),
                  makeInput(label: "닉네임", controller: nicknameController),
                  makeInput(label: "이메일", controller: emailController),
                  makeInput(
                      label: "비밀번호",
                      obscureText: true,
                      controller: passController),
                  makeInput(
                      label: "비밀번호 확인",
                      obscureText: true,
                      controller: passController),
                  makeInput(label: "전화번호", controller: phoneController),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    singupUser(
                        emailController, passController, nameController, nicknameController, phoneController);
                  },
                  color: const Color(0xFF087560),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: const Text(
                    "회원가입",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("계정이 있으신가요?    ",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        // fontSize: 18,
                        color: Colors.white, // 흰색으로 변경
                      ),),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const LoginPage());
                      },
                      child: const Text(
                        " 로그인",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false, TextEditingController? controller}) {

    String hintText = "";

    if (label == "이름") {
      hintText = "이름을 입력해주세요.";
    } else if (label == "닉네임") {
      hintText = "닉네임을 입력해주세요.";
    }else if (label == "이메일") {
      hintText = "이메일을 입력해주세요.";
    } else if (label == "비밀번호") {
      hintText = "패스워드를 입력해주세요.";
    } else if (label == "비밀번호 확인") {
      hintText = "패스워드를 다시 입력해주세요.";
    } else if (label == "전화번호") {
      hintText = "전화번호를 입력해주세요.";
    }



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  void singupUser(emailController, passController, nameController, nicknameController, phoneController) {
    registerUser(emailController.text.trim(), passController.text.trim(),
            nameController.text.trim(), nicknameController.text.trim(), phoneController.text.trim())
        .then((value) => {
              if (value)
                {
                  emailController.clear(),
                  passController.clear(),
                  nameController.clear(),
                  nicknameController.clear(),
                  phoneController.clear(),
                  Get.off(() => const LoginPage())
                }
            });
  }
}
