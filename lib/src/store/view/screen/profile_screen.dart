import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Expanded(child: Image.asset('assets/images/profile_pic.png')),
          // const Text(
          //   "Hello Sina!",
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Image.asset('assets/images/github.png', width: 60),
          //     const SizedBox(width: 10),
          //     const Text(
          //       "https://github.com/SinaSys",
          //       style: TextStyle(fontSize: 20),
          //     )
          //   ],
          // ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderInfoPage()),
              );
            },
            child: Text("주문정보 확인"),
          ),
        ],
      ),
    );
  }
}

class OrderInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("주문정보 페이지"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "주문번호: 12345",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "상품명: 샘플 상품",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "가격: \$50",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
