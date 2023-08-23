import 'dart:convert';

class User {
  String email;
  String password;
  String cpassword;
  String name;
  String nickname;
  String phone;

  get getEmail => email;

  void setEmail(email) => this.email = email;

  get getPassword => password;

  void setPassword(password) => this.password = password;

  get getCpassword => cpassword;

  void setCpassword(cpassword) => this.cpassword = cpassword;

  get getName => name;

  void setName(name) => this.name = name;

  get getNickname => nickname;

  void setNickname(nickname) => this.nickname = nickname;

  get getPhone => phone;

  void setPhone(phone) => this.phone = phone;

  User({
    required this.email,
    required this.password,
    required this.cpassword,
    required this.name,
    required this.nickname,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'cpassword': cpassword,
      'name': name,
      'nickname': nickname,
      'phone': phone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      password: map['password'] as String,
      cpassword: map['cpassword'] as String,
      name: map['name'] as String,
      nickname: map['nickname'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
