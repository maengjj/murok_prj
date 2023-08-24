import 'dart:convert';

class User {
  String email;
  String passwrd;
  // String cpassword;
  String name;
  String nickname;
  String phoneNum;

  get getEmail => email;

  void setEmail(email) => this.email = email;

  get getPassword => passwrd;

  void setPassword(password) => this.passwrd = passwrd;

  // get getCpassword => cpassword;
  //
  // void setCpassword(cpassword) => this.cpassword = cpassword;

  get getName => name;

  void setName(name) => this.name = name;

  get getNickname => nickname;

  void setNickname(nickname) => this.nickname = nickname;

  get getPhone => phoneNum;

  void setPhone(phoneNum) => this.phoneNum = phoneNum;

  User({
    required this.email,
    required this.passwrd,
    // required this.cpassword,
    required this.name,
    required this.nickname,
    required this.phoneNum,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'passwrd': passwrd,
      // 'cpassword': cpassword,
      'name': name,
      'nickname': nickname,
      'phoneNum': phoneNum,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      passwrd: map['password'] as String,
      // cpassword: map['cpassword'] as String,
      name: map['name'] as String,
      nickname: map['nickname'] as String,
      phoneNum: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
