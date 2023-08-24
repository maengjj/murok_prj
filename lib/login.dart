import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:murok_prj/murok_main.dart';
import 'package:murok_prj/signup.dart';
import 'package:murok_prj/utils/helper.dart';

import 'dashboard.dart';
import 'intro_page.dart';
import 'chatbot.dart';
import 'profile_page.dart';
import 'layout.dart';
import 'dashboard.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
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
        //   "로그인",
        //   style: TextStyle(
        //       fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        // ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height / 3,
                          //   child: const Image(
                          //     colorBlendMode: BlendMode.overlay,
                          //     image: AssetImage('assets/background.png'),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40), // 변경된 부분
                            child: const Text(
                              "로그인",
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 20,)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: <Widget>[
                            makeInput(
                                label: "이메일", controller: emailController),
                            makeInput(
                                label: "비밀번호",
                                obscureText: true,
                                controller: passController),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: const EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {
                              // Get.to(() => LayoutPage());
                               loginUser(emailController, passController);  //로그인 구현!!!!
                            },
                            color: const Color(0xFFFFFFFF),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(color: Colors.white),),
                            child: const Text(
                              "로그인",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Color(0xFF06C09F)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("계정이 없으신가요?    ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                // fontSize: 18,
                                color: Colors.white, // 흰색으로 변경
                              ),),

                            GestureDetector(
                              onTap: () {
                                Get.to(() => const SignupPage());
                              },
                              child: const Text(
                                "회원가입",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false, required controller}) {

    String hintText = "";

    if (label == "이메일") {
      hintText = "이메일을 입력해주세요.";
    } else if (label == "비밀번호") {
      hintText = "패스워드를 입력해주세요.";
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
          height: 30,
        ),
      ],
    );
  }
}

void loginUser(emailController, passController) {
  loginUserWithEmail(
    emailController.text.trim(),
    passController.text.trim(),
  ).then((value) => {
        if (value)
          {
            emailController.clear(),
            passController.clear(),
            Future.delayed(const Duration(seconds: 1),
                () => {Get.offAll(() => LayoutPage())})
                // () => {Get.offAll(() => DashboardPage())})
          }
      });
}
