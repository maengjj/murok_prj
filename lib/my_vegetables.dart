import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:untitled1/main.dart';
// import 'package:untitled1/network.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'network.dart';

class MyVegetables extends StatefulWidget {
  const MyVegetables({super.key});

  @override
  State<MyVegetables> createState() => _MyVegetablesState();
}

class _MyVegetablesState extends State<MyVegetables> {
  List data = [];

  Future<String> getData() async {
    // http.Response response = await http.get(
    //   Uri.parse('http://15.164.103.233:3000/app/plants'),
    // );
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      var url = Uri.parse('http://15.164.103.233:3000/app/plants');
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


    print(data);
    return "success";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context); // 현재 페이지를 닫고 이전 페이지로 돌아가기
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
          title: Text("내 작물정보", style: TextStyle(color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 1.2,)),
          // actions: [
          //   TextButton(onPressed: () {},
          //       child: Container(child: Text('추가하기'),
          //         padding: EdgeInsets.fromLTRB(0, 0, 10, 0),))
          // ],
          backgroundColor: Color(0xff06C09F), toolbarHeight: 80),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
            final item = data[index]['name'];

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4.0,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  getVegggieImage(data[index]["name"]),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Text(
                            data[index]["nickname"],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              color: Colors.blueGrey.shade700,
                            ),
                          ),
                          Container(
                            child: new Text(
                              '작물 분류 | ' + data[index]["name"],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade500,
                              ),
                            ),
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          ),
                          new Text(
                            '심은 날짜 | ' +
                                DateFormat('yyyy/MM/dd').format(
                                  DateTime.parse(data[index]["frequency_start"]),
                                ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                          new Text(
                            '적정 온도 | ' + data[index]["temperature"],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                          new Text(
                            '적정 토양 | ' + data[index]["soil_type"],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.fromLTRB(20, 20, 5, 20),
            ),
          );
        },
      ),

    );
  }

  Widget getVegggieImage(name) {
    switch (name) {
      case '감자':
        return const Image(image: AssetImage('images/potato.png'), width : 150);
      case '상추' :
        return const Image(image: AssetImage('images/sangchoo.png'), width : 150);
      case '고추' :
        return const Image(image: AssetImage('images/pepper.png'), width : 150);
      case '방울토마토' :
        return const Image(image: AssetImage('images/tomato.png'), width : 150);
      case '딸기' :
        return const Image(image: AssetImage('images/strawberry.png'), width : 150);
      case '고구마' :
        return const Image(image: AssetImage('images/sweet_potato.png'), width : 150);
      case '대파' :
        return const Image(image: AssetImage('images/springonion.png'), width : 150);
      default:
        return const Image(image: AssetImage('images/todaysolid.png'), width : 150);
    }
  }
}

class VeggieCard extends StatelessWidget {
  final String veggie_name;
  final String vegetables;
  const VeggieCard(this.veggie_name, this.vegetables);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4.0,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(image: AssetImage('images/todaysolid.png'), width : 100),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$veggie_name', style : TextStyle( fontSize: 24, fontWeight: FontWeight.bold,  height: 1.2, color: Colors.blueGrey.shade700)),
                      Container(child: Text('작물 종류 | $vegetables', style : TextStyle( fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade500, height: 1.5)), margin: EdgeInsets.fromLTRB(0, 5, 0, 5),),
                      Text('심은 날짜 | ', style : TextStyle( fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade800 )),
                      Text('적정 온도 | ', style : TextStyle( fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade800 )),
                      Text('적정 토양 | ', style : TextStyle( fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade800 ),maxLines: 2, overflow: TextOverflow.ellipsis, softWrap: true,),
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(40, 0, 0, 0),)
              ],
            ),
            margin: EdgeInsets.fromLTRB(40,20,20,20),),
        ),
        margin: EdgeInsets.fromLTRB(20, 10, 20, 0));
  }
}


Widget _createFolderInDrawer(String folderName) {
  return Container(
    padding: EdgeInsets.all(8.0),
    child: TextButton(onPressed: (){
    }, child: Text(folderName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)),
    margin: EdgeInsets.fromLTRB(10, 8, 0, 0),);
}

