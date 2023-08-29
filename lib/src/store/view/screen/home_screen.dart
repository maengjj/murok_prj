import 'package:murok_prj/src/store/view/widget/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:murok_prj/core/app_data.dart';
import 'package:murok_prj/src/store/view/screen/cart_screen.dart';
import 'package:murok_prj/src/store/view/screen/profile_screen.dart';
import 'package:murok_prj/src/store/view/screen/favorite_screen.dart';
import 'package:murok_prj/src/store/view/screen/product_list_screen.dart';
import 'package:murok_prj/core/app_theme.dart';
import 'dart:ui' show PointerDeviceKind;



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
    return Theme(
      data: AppTheme.lightAppTheme,
      child: PageWrapper(
        child: ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            },
          ),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              title: Text(
                "무럭마켓",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              backgroundColor: Color(0xff06C09F),
              toolbarHeight: 80,
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
            bottomNavigationBar: Container(
              height: 60, // 원하는 높이로 설정하세요
              child: BottomNavyBar(
                itemCornerRadius: 10,
                selectedIndex: newIndex,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            ),
          ),
        ),
      ),
    );
  }

}
