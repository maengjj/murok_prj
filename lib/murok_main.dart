import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:murok_prj/alarm_note.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


import 'my_vegetables.dart';
import 'profile_page.dart';
import 'chatbot.dart';
import 'login.dart';
import 'alarm_note.dart';

class MurokMain extends StatefulWidget {
  const MurokMain({Key? key}) : super(key: key);

  @override
  _MurokMainState createState() => _MurokMainState();
}

class _MurokMainState extends State<MurokMain> {
  List data = [];

  Future<String> getData() async {



    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      var url = Uri.parse('http://15.164.103.233:3000/app/plants/freq');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'x-access-token': '$token'
      };


      var response = await http.get(url, headers: headers);

      print(response.body);


      setState(() {
        data = json.decode(response.body);
      });
    }








    // http.Response response = await http.get(
    //   Uri.parse('http://15.164.103.233:3000/app/plants/freq'),
    // );

    // print(response);

    // setState(() {
    //   data = json.decode(response.body);
    // });

    // print(response);

    print(data);
    return "success";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Widget build(BuildContext context) {
    initializeDateFormatting('ko');
    final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
    String formattedDate = new DateFormat('yyyy년 MM월 dd일 EEEE', 'ko').format(
        DateTime.now());
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('ko'),
      ],
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff06C09F),
        useMaterial3: true,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //     title: Image(width: 80, image: AssetImage('images/wlogo.png'),),
        //     actions: [Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: IconButton(
        //           onPressed: () {}, icon: Icon(Icons.notifications)),
        //     )
        //     ],
        //     centerTitle: true,
        //     backgroundColor: Color(0xff06C09F),
        //     toolbarHeight: 80),
        body: SlidingUpPanel(
          minHeight: 100,
          maxHeight: 430,
          borderRadius: radius,
          panel: Column(
            children: [
              Container(child: Image(
                image: AssetImage('images/grey_bar.png'), width: 50,),
                padding: EdgeInsets.all(10),),
              Container(
                child: Text('오늘의 할 일',
                  style: TextStyle(
                    color: Color(0xff06C09F),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),),
              Column(
                children: [
                  TodayWater(data),
                  TodayNutrition(data),
                  TodaySolid(data),
                ],
              )
            ],
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('$formattedDate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                        ),),
                      Container(
                        child: TimerBuilder.periodic(
                          const Duration(seconds: 1),
                          builder: (context) {
                            return Text(
                              DateFormat('HH시 mm분').format(DateTime.now()),
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                      Text('',
                          style: TextStyle(
                            height: 0.5,
                          )),
                      Text('오늘의 할 일을 확인해봐요!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          height: 1.2,
                        ),),
                      // Text('오늘의 할 일을 확인해봐요!',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w300,
                      //     height: 1.2,
                      //   ),),
                    ],
                  ),
                  margin: EdgeInsets.only(top: 30),
                  padding : EdgeInsets.all(20)
                  ,),
                Container(
                  child: Image(
                      width: 600, image: AssetImage('images/main_muroki.gif')),
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),),
                Container(
                  color: Color(0xff8AD6C8),
                )
              ],
            ),
            color: Color(0xff8AD6C8),),
        ),
        // bottomNavigationBar: CustomBottomNavigation(),
        // drawer: SideBarList(),
      ),
    );
  }
}






class SideBarList extends StatelessWidget {
  const SideBarList({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('images/circle_muroki.png'),
            ),
            accountName: Text('무럭이',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            accountEmail: Text('muroki@gmail.com'),
            onDetailsPressed: () {},
            decoration: BoxDecoration(
              color: Color(0xff06C09F),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.storefront),
            iconColor: Color(0xff06C09F),
            focusColor: Color(0xff06C09F),
            title: Text('무럭마켓',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
            onTap: () {},
            trailing: Icon(Icons.navigate_next),
          ),
          ListTile(
            leading: Icon(Icons.question_mark_rounded),
            iconColor: Color(0xff06C09F),
            focusColor: Color(0xff06C09F),
            title: Text('질문하기',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
            onTap: () {},
            trailing: Icon(Icons.navigate_next),
          ),
          ListTile(
            leading: Icon(Icons.list_alt),
            iconColor: Color(0xff06C09F),
            focusColor: Color(0xff06C09F),
            title: Text('내 작물정보',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const MyVegetables()),);},
            trailing: Icon(Icons.navigate_next),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            iconColor: Color(0xff06C09F),
            focusColor: Color(0xff06C09F),
            title: Text('로그아웃',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
            onTap: () {
              Get.to(() => LoginPage());
            },
            trailing: Icon(Icons.navigate_next),
          )
        ],
      ),
    );
  }
}

class TodayWater extends StatelessWidget {
  final List data;
  const TodayWater(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image(image: AssetImage('images/todaywater.png'), width : 70),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('물 주기', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.5, color: Colors.blueGrey.shade700)),
                Row(
                  children: List.generate(data.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(data[index]['name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey)),
                    );
                  }),
                )
              ],
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
          )
        ],
      ),
      margin: EdgeInsets.all(10), padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
    );
  }
}

class TodaySolid extends StatelessWidget {
  final List data;
  const TodaySolid(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image(image: AssetImage('images/todaysolid.png'), width : 70),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('수확 하기', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.5, color: Colors.blueGrey.shade700)),
                Row(
                  children: List.generate(data.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(data[index]['name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey)),
                    );
                  }),
                )
              ],
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
          )
        ],
      ),
      margin: EdgeInsets.all(10), padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
    );
  }
}


class TodayNutrition extends StatelessWidget {
  final List data;
  const TodayNutrition(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image(image: AssetImage('images/todaynutrition.png'), width : 70),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('영양제 주기', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.5, color: Colors.blueGrey.shade700)),
                Row(
                  children: List.generate(data.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(data[index]['name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey)),
                    );
                  }),
                )
              ],
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
          )
        ],
      ),
      margin: EdgeInsets.all(10), padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
    );
  }
}


// 하단 네비게이션 바에 대한 옵션은 여기서.
class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton( icon : Icon(Icons.question_answer), onPressed: (){
            }, iconSize: 40, focusColor: Colors.white, hoverColor: Colors.white,),
            IconButton( icon : Icon(Icons.home), onPressed: (){}, iconSize: 40, focusColor: Colors.white, hoverColor: Colors.white,),
            IconButton( icon : Icon(Icons.account_circle), onPressed: (){}, iconSize: 40, focusColor: Colors.white, hoverColor: Colors.white,),
          ],
        ),
      ), color: Color(0xff06C09F),
    );
  }
}

class ImportantInformation extends StatelessWidget {
  const ImportantInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Row(
        children: [
          Image(image: AssetImage('images/todaynutrition.png'), width : 100),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ㅎㅎㅇ의 역할', style : TextStyle( fontSize: 24, fontWeight: FontWeight.bold,  height: 2.0, color: Colors.blueGrey.shade700)),
                Text('글쎄요... 말로만 노력하기?', style : TextStyle( fontSize: 20, fontWeight: FontWeight.normal, color: Colors.grey ))
              ],
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),)
        ],
      ),
      margin: EdgeInsets.all(10),padding: EdgeInsets.fromLTRB(15, 0, 0, 0),);
  }
}

