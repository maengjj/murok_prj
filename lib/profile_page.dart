import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:murok_prj/login.dart';
import 'package:get/get.dart';
import 'package:murok_prj/main.dart';
import 'package:image_picker/image_picker.dart';
import 'utils/helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


import 'murok_main.dart';
import 'signup.dart';


class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  // File? _imageFile;



  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: true,
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 280.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[

                        Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 140.0,
                                    height: 200.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: new ExactAssetImage(
                                            'images/as.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 130.0, right: 100.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new CircleAvatar(
                                      backgroundColor: Color(0xFF087560),
                                      radius: 25.0,
                                      child: new Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 190.0),
                              child: Center(
                                child:
                                FutureBuilder(
                                    future: getUserProfile(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(snapshot.data!.email,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                            fontFamily: 'sans-serif-light',
                                            color: Colors.grey,
                                          ),);
                                      }
                                      else {return Text('');}
                                    }
                                ),
                              ),
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        '회원 정보',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? _getEditIcon() : new Container(),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        '이름',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: FutureBuilder(
                                      future: getUserProfile(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          // 데이터 로딩 중
                                          return TextField(
                                            controller: TextEditingController(text:''),);
                                        } else if (snapshot.hasData) {
                                          // 데이터 로딩 완료 및 데이터가 있는 경우
                                          return TextField(
                                            decoration: InputDecoration(
                                              hintText: "이름 입력해주세요.",
                                            ),
                                            enabled: !_status,
                                            controller: TextEditingController(text: snapshot.data!.name),
                                            onChanged: (text) async {
                                              if (_status = true) { // Use '==' for comparison, not '='
                                                print(text);
                                              }
                                            },
                                            // 위젯을 활성화한 상태로 보여줄 때 TextField에 기본 텍스트 설정
                                          );
                                        } else {
                                          // 데이터 로딩 실패 또는 데이터가 없는 경우
                                          return TextField(
                                            decoration: InputDecoration(
                                              hintText: "이름 입력해주세요.",
                                            ),
                                            enabled: !_status,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        '닉네임',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: FutureBuilder(
                                      future: getUserProfile(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          // 데이터 로딩 중
                                          return TextField(
                                            controller: TextEditingController(text:''),);
                                        } else if (snapshot.hasData) {
                                          // 데이터 로딩 완료 및 데이터가 있는 경우
                                          return TextField(
                                            decoration: InputDecoration(
                                              hintText: "닉네임 입력해주세요.",
                                            ),
                                            enabled: !_status,
                                            controller: TextEditingController(text: snapshot.data!.nickname),
                                            onChanged: (text) async {
                                              if (_status = true) { // Use '==' for comparison, not '='
                                                print(text);

                                              }
                                            },
                                            // 위젯을 활성화한 상태로 보여줄 때 TextField에 기본 텍스트 설정
                                          );
                                        } else {
                                          // 데이터 로딩 실패 또는 데이터가 없는 경우
                                          return TextField(
                                            decoration: InputDecoration(
                                              hintText: "닉네임 입력해주세요.",
                                            ),
                                            enabled: !_status,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        '전화번호',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: FutureBuilder(
                                      future: getUserProfile(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          // 데이터 로딩 중
                                          return TextField(
                                            controller: TextEditingController(text:''),);
                                        } else if (snapshot.hasData) {
                                          // 데이터 로딩 완료 및 데이터가 있는 경우
                                          return TextField(
                                            decoration: InputDecoration(
                                              hintText: "전화번호 입력해주세요.",
                                            ),
                                            enabled: !_status,
                                            controller: TextEditingController(text: snapshot.data!.phoneNum),
                                            onChanged: (text) async {
                                              if (_status = true) { // Use '==' for comparison, not '='
                                                print(text);

                                              }
                                            },
                                            // 위젯을 활성화한 상태로 보여줄 때 TextField에 기본 텍스트 설정
                                          );
                                        } else {
                                          // 데이터 로딩 실패 또는 데이터가 없는 경우
                                          return TextField(
                                            decoration: InputDecoration(
                                              hintText: "전화번호 입력해주세요.",
                                            ),
                                            enabled: !_status,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )),
                          !_status ? _getActionButtons() : new Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new ElevatedButton(
                    child: new Text("저장"), style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(color: Colors.green), // Change text color here
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Change the radius value as needed
                    ),// Change background color here
                  ),
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    // shape: new RoundedRectangleBorder(
                    //     borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(color: Colors.white),
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text("취소"),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Color(0xFF087560),
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}