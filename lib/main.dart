import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:murok_prj/dashboard.dart';
import 'package:murok_prj/utils/helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http; // http 패키지 가져오기
import 'package:shared_preferences/shared_preferences.dart';


import 'intro_page.dart';
import 'alarm_note.dart';
import 'layout.dart';
import 'chatbot.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // 메시지 값을 alarm_note.dart 파일의 변수에 할당합니다.
  AlarmNote.messageBody = message.notification!.body;
  // 메시지 값을 출력합니다.
  AlarmNote.printMessage();

  print("백그라운드 메시지 처리.. ${message.notification!.body!}");

  // 알림 생성 및 표시 로직 추가
  if (message.notification != null) {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.show(
      message.notification!.hashCode,
      message.notification!.title ?? '', // title이 null인 경우 빈 문자열 처리
      message.notification!.body ?? '', // body가 null인 경우 빈 문자열 처리
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'high_importance_notification',
          importance: Importance.max,
        ),
      ),
    );
  }
}



void initializeNotification() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
      'high_importance_channel', 'high_importance_notification',
      importance: Importance.max));

  await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
    android: AndroidInitializationSettings("@mipmap/ic_launcher"),
  ));

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // notification 설정
  // String? firebaseToken = await fcmSetting();
  // await FirebaseMessaging.instance.getToken();
  initializeNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(GetMaterialApp(
      theme: ThemeData(fontFamily: 'Pretendard'),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false, home: MainPage()));
}

class MainPage extends StatefulWidget {
  // Datetime now = DateTime.now();
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  var messageString = "";

  Future<void> getMyDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("내 디바이스 토큰: $token");

    if (token != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('deviceToken', token);
    } else {
      print("토큰이 없습니다.");
    }

  }



  @override
  void initState() {

    getMyDeviceToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'high_importance_notification',
              importance: Importance.max,
            ),
          ),
        );

        // 메시지 값을 alarm_note.dart 파일의 변수에 할당합니다.
        AlarmNote.messageBody = message.notification!.body;
        // 메시지 값을 출력합니다.
        AlarmNote.printMessage();


        setState(() {
          messageString = message.notification!.body!;
          print("Foreground 메시지 수신: $messageString");
        });

      }
    });
    super.initState();




    userProfileAvailble().then((value) async => {
      Timer(const Duration(seconds: 3), () {
        if (value) {
          Get.off(() => const IntroPage());
        } else {
          Get.off(() => const IntroPage());
          // Get.to(() => ChatBot());
        }
        // 타이머 설정
        _sendGetRequestWithTokenAfterDelay();


      })
    });
    super.initState();
  }



  Future<void> _sendGetRequestWithToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('deviceToken');

    if (token != null) {
      final url = Uri.parse('http://15.164.103.233:3000/push');
      final headers = <String, String>{
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
          print('GET 요청 성공');
          print('서버 응답 데이터: ${response.body}');

      } else {
        print('GET 요청 실패: ${response.statusCode}');
      }
    } else {
      print('토큰이 없습니다.');
    }
  }

  void _sendGetRequestWithTokenAfterDelay() {
    Timer(const Duration(seconds: 5), () {
      _sendGetRequestWithToken();
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
              Container(child: Image.asset('assets/murok_logo.png', width: 100,),
                padding: EdgeInsets.only(bottom: 10),), // 추가 이미지 설정
              // const SizedBox(height: 30),
              const Text("나만의 텃밭 길잡이", style: TextStyle(fontSize: 24, color: Colors.white)),
              const SizedBox(height: 60),
              const CircularProgressIndicator(color: Colors.white),
            ],
          )),
    );
  }
}
