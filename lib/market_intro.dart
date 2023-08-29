import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:murok_prj/core/app_theme.dart';
import 'package:murok_prj/src/store/view/screen/home_screen.dart';

class MarketIntro extends StatelessWidget {
  const MarketIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: AppTheme.lightAppTheme,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // 여기서 앱 초기화 작업을 수행하고,
    // 초기화 작업이 완료되면 HomeScreen으로 이동하도록 설정합니다.

    // 예를 들어, 초기화 작업 완료 시 2초 후 HomeScreen으로 이동
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
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
            ), // 추가 이미지 설정
            const Text(
              "무럭마켓",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 60),
            // const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
