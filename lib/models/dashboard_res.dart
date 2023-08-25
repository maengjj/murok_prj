// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DashboardRes {
  bool status;
  String msg;
  String email;
  String nickname;
  String phoneNum;
  String name;
  DashboardRes({
    required this.status,
    required this.msg,
    required this.email,
    required this.nickname,
    required this.phoneNum,
    required this.name,
  });
  get getStatus => status;

  void setStatus(status) => this.status = status;

  get getMsg => msg;

  void setMsg(msg) => this.msg = msg;

  get getEmail => email;

  void setEmail(email) => this.email = email;

  get getNickname => nickname;

  void setNickname(nickname) => this.nickname = nickname;

  get getPhoneNum => phoneNum;

  void setPhoneNum(phoneNum) => this.phoneNum = phoneNum;

  get getName => name;

  void setName(name) => this.name = name;


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'msg': msg,
      'email': email,
      'nickname': nickname,
      'phoneNum' : phoneNum,
      'name' : name
    };
  }

  factory DashboardRes.fromMap(Map<String, dynamic> map) {
    return DashboardRes(
      status: map['isSuccess'] as bool,
      msg: map['message'] as String,
      email: map['result']['email'] as String,
      nickname: map['result']['nickname'] as String,
      phoneNum: map['result']['phoneNum'] as String,
      name: map['result']['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardRes.fromJson(String source) =>
      DashboardRes.fromMap(json.decode(source) as Map<String, dynamic>);
}
