import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:murok_prj/calendar.dart';
import 'package:murok_prj/src/store/view/screen/home_screen.dart';

import 'murok_main.dart';
import 'chatbot.dart';
import 'profile_page.dart';
import 'package:get/get.dart';
import 'alarm_note.dart';
import 'login.dart';
import 'my_vegetables.dart';
import 'market_intro.dart';
import 'utils/helper.dart';
import 'calendar.dart';


class LayoutPage extends StatefulWidget {
  LayoutPage({Key? key, this.title= ''}) : super(key: key);
  final String title;

  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  final List<Widget> _children = [ChatBot(), MurokMain(), ProfilePage()];
  int _currentIndex = 1;

  final pageController = PageController(initialPage: 1);

  void onTabClickHandle(int _index) {
    print('onTabClickHandle $_index');
    pageController.jumpToPage(_index);
  }

  void onPageChangeHandler(int _index) {
    print('onPageChangeHandler $_index');
    setState(() {
      _currentIndex = _index;
    });
  }

  // 각 페이지에 대한 이미지와 텍스트를 포함한 리스트를 정의합니다.
  final List<Widget> _pageContents = [
    // Text(''),
    Text('무럭이와 대화',
          style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
          height: 1.2,
          fontFamily: 'sans-serif-light',
          color: Colors.white,
          ),
          ), // 첫 번째 페이지에 텍스트
    Image.asset('images/wlogo.png', width: 80,), // 두 번째 페이지에 이미지
    Text("마이페이지",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
          height: 1.2,
          fontFamily: 'sans-serif-light',
          color: Colors.white,),), // 세 번째 페이지에 텍스트
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // 페이지에 따라 이미지 또는 텍스트를 표시
            title: _pageContents[_currentIndex],
            actions: [Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    Get.to(() => AlarmNote());
                  }, icon: Icon(Icons.notifications)),
            )
            ],
            centerTitle: true,
            backgroundColor: Color(0xff06C09F),
            toolbarHeight: 80),
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChangeHandler,
          children: _children,
          // physics: NeverScrollableScrollPhysics()
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: onTabClickHandle,
            currentIndex: _currentIndex,
            backgroundColor: Color(0xff06C09F),
            selectedItemColor: Colors.white, // 선택된 아이템의 아이콘 색상
            unselectedItemColor: Colors.black54, // 선택되지 않은 아이템의 아이콘 색상
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.question_answer, size: 50),
                label: "챗봇",
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 50),
                label: "홈",
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 50),
                label: "마이페이지",
              )
            ]),
        drawer: SideBarList(),
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
              backgroundImage: AssetImage('images/circle_muroki.png',),
              backgroundColor: Color(0xff06C09F),
            ),
            accountName: FutureBuilder(
                future: getUserProfile(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.nickname,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white,
                      ),);
                  }
                  else {return Text('');}
                }
            ),
            accountEmail: FutureBuilder(
                future: getUserProfile(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.email,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),);
                  }
                  else {return Text('');}
                }
            ),
            // onDetailsPressed: () {},
            decoration: BoxDecoration(
              color: Color(0xff06C09F),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
          ),

          // ListTile(
          //   leading: Icon(Icons.question_mark_rounded),
          //   iconColor: Color(0xff06C09F),
          //   focusColor: Color(0xff06C09F),
          //   title: Text('질문하기',
          //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
          //   onTap: () {},
          //   trailing: Icon(Icons.navigate_next),
          // ),
          ListTile(
            leading: Icon(Icons.list_alt),
            iconColor: Color(0xff06C09F),
            focusColor: Color(0xff06C09F),
            title: Text('내 작물정보',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const MyVegetables()),);
              Get.to(() => MyVegetables());
              },
            trailing: Icon(Icons.navigate_next),
          ),
          ListTile(
            leading: Icon(Icons.calendar_month),
            iconColor: Color(0xff06C09F),
            focusColor: Color(0xff06C09F),
            title: Text('캘린더',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const MyVegetables()),);
              Get.to(() => CalendarScreen());
            },
            trailing: Icon(Icons.navigate_next),
          ),
          ListTile(
            leading: Icon(Icons.storefront),
            iconColor: Color(0xff06C09F),
            focusColor: Color(0xff06C09F),
            title: Text('무럭마켓',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
            onTap: () {
              Get.to(() => MarketIntro());
            },
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
  final String water_veggies;
  const TodayWater(this.water_veggies);

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Row(
        children: [
          Image(image: AssetImage('images/todaywater.png'), width : 100),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('물 주기', style : TextStyle( fontSize: 24, fontWeight: FontWeight.bold,  height: 2.0, color: Colors.blueGrey.shade700)),
                Text('$water_veggies', style : TextStyle( fontSize: 20, fontWeight: FontWeight.normal, color: Colors.grey ))
              ],
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),)
        ],
      ),
      margin: EdgeInsets.all(10),padding: EdgeInsets.fromLTRB(15, 0, 0, 0),);
  }
}

class TodaySolid extends StatelessWidget {
  const TodaySolid({super.key});

  @override
  Widget build(BuildContext context) {
    String vegetables = '상추, 케일';
    return  Container(
      child: Row(
        children: [
          Image(image: AssetImage('images/todaysolid.png'), width : 100),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('분갈이 하기', style : TextStyle( fontSize: 24, fontWeight: FontWeight.bold,  height: 2.0, color: Colors.blueGrey.shade700)),
                Text('$vegetables', style : TextStyle( fontSize: 20, fontWeight: FontWeight.normal, color: Colors.grey ))
              ],
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),)
        ],
      ),
      margin: EdgeInsets.all(10),padding: EdgeInsets.fromLTRB(15, 0, 0, 0),);
  }
}

class TodayNutrition extends StatelessWidget {
  const TodayNutrition({super.key});

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
                Text('영양제 주기', style : TextStyle( fontSize: 24, fontWeight: FontWeight.bold,  height: 2.0, color: Colors.blueGrey.shade700)),
                Text('방울토마토', style : TextStyle( fontSize: 20, fontWeight: FontWeight.normal, color: Colors.grey ))
              ],
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),)
        ],
      ),
      margin: EdgeInsets.all(10),padding: EdgeInsets.fromLTRB(15, 0, 0, 0),);
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

