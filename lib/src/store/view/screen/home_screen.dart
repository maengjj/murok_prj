import 'package:murok_prj/src/store/view/widget/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:murok_prj/core/app_data.dart';
import 'package:murok_prj/src/store/view/screen/cart_screen.dart';
import 'package:murok_prj/src/store/view/screen/profile_screen.dart';
import 'package:murok_prj/src/store/view/screen/favorite_screen.dart';
import 'package:murok_prj/src/store/view/screen/product_list_screen.dart';


import 'package:get/get.dart';
import 'package:murok_prj/layout.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const List<Widget> screens = [
    ProductListScreen(),
    // FavoriteScreen(),
    CartScreen(),
    ProfileScreen()
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int newIndex = 0;

  @override
  void initState() {
    super.initState();
    newIndex = 0; // 초기값을 설정해줍니다.
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
                Get.back();
                // Get.to(() => LayoutPage());
                // Navigator.popUntil(context, ModalRoute.withName('/'));
                // Navigator.pop(context); // 현재 페이지를 닫고 이전 페이지로 돌아가기
                // Navigator.of(context).popUntil((route) => route.isFirst);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
            title: Text("무럭마켓", style: TextStyle(color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.2,)),
            // actions: [
            //   TextButton(onPressed: () {},
            //       child: Container(child: Text('추가하기'),
            //         padding: EdgeInsets.fromLTRB(0, 0, 10, 0),))
            // ],
            backgroundColor: Color(0xff06C09F), toolbarHeight: 80),
        bottomNavigationBar: BottomNavyBar(
          itemCornerRadius: 10,
          selectedIndex: newIndex,
          items: AppData.bottomNavyBarItems
              .map(
                (item) => BottomNavyBarItem(
                  icon: item.icon,
                  title: Text(item.title),
                  activeColor: item.activeColor,
                  inactiveColor: item.inActiveColor,
                ),
              )
              .toList(),
          onItemSelected: (currentIndex) {
            newIndex = currentIndex;
            setState(() {});
          },
        ),
        body: PageTransitionSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: HomeScreen.screens[newIndex],
        ),
      ),
    );
  }
}
