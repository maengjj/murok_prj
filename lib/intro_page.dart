import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:murok_prj/signup.dart';

import 'login.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF06C09F),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .80,
            // height: 200,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[],
                ),
                Container(
                  // height: MediaQuery.of(context).size.height / 3,
                  // height: 150,
                  child: const Image(
                    colorBlendMode: BlendMode.overlay,
                    image: AssetImage('images/main_muroki.png'),
                    width: 250,
                    height: 250,
                  ),
                  padding: EdgeInsets.only(bottom: 0),
                ),
                Container(child: Image.asset('assets/murok_logo.png', width:150,),
                padding: EdgeInsets.only(bottom: 10),), // 추가 이미지 설정

                const Text("나만의 텃밭 길잡이", style: TextStyle(fontSize: 20, color: Colors.white)),
                SizedBox(height: 50),
                Column(
                  children: <Widget>[
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Get.to(() => const LoginPage());
                      },
                      color: const Color(0xFFFFFFFF),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text(
                        "로그인",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xFF06C09F)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          Get.to(() => const SignupPage());
                        },
                        color: const Color(0xFF087560),
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
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Color(0xFF06C09F),
        child: const Text(
          "2023 TABA 3기\n장요한, 이진영, 맹지주, 김정현, 황혜영",
          style: TextStyle(fontSize: 16, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
