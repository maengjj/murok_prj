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

            return Dismissible(key: Key(item), child:

          Card(
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
                                  DateTime.parse(data[index]["created_at"]),
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
          ),
              // background: Container(color: Colors.red),
              background: Container(color: Colors.red),
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("작물 삭제"),
                      content: Text("이 작물을 삭제하시겠습니까?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false), // 취소 버튼
                          child: Text("취소"),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop(true); // 확인 버튼
                            // 실제 삭제 작업 수행 및 데이터 업데이트
                            await _deleteData(data[index]["id"]);
                            setState(() {
                              data.removeAt(index);
                            });
                          },
                          child: Text("확인"),
                        ),
                      ],
                    );
                  },
                );
              },
            );
        },
      ),

    );
  }

  Future<void> _deleteData(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final url = Uri.parse('http://15.164.103.233:3000/app/plants/delete?id=${id}'); // 실제 API 엔드포인트로 변경

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-access-token': '$token', // 요청 헤더 설정
      },
      body: jsonEncode({'id': id}),
    );

    print(response.body);



    if (response.statusCode == 200) {
      // 성공적으로 삭제된 경우의 처리
      print('Data deleted successfully');
    } else {
      // 삭제 실패 시의 처리
      print('Failed to delete data');
    }
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

