import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:murok_prj/core/app_theme.dart';
import 'package:murok_prj/src/store/view/screen/home_screen.dart';
import 'dart:async'; // 이 부분을 추가해주세요
//
// class MarketIntro extends StatelessWidget {
//   const MarketIntro({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       scrollBehavior: const MaterialScrollBehavior().copyWith(
//         dragDevices: {
//           PointerDeviceKind.mouse,
//           PointerDeviceKind.touch,
//         },
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const HomeScreen(),
//       theme: AppTheme.lightAppTheme,
//     );
//   }
// }

class MarketIntro extends StatefulWidget {
  const MarketIntro({Key? key}) : super(key: key);

  @override
  _MarketIntroState createState() => _MarketIntroState();
}

class _MarketIntroState extends State<MarketIntro> {
  @override
  void initState() {
    super.initState();

    // 1초 후에 HomeScreen으로 이동하는 타이머 설정
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF06C09F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('images/wlogo.png', width: 150,),
              padding: EdgeInsets.only(bottom: 10),
            ),
            const Text(
              "무럭마켓",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
