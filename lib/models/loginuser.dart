// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginUser {
  String email;
  String passwrd;
  LoginUser({
    required this.email,
    required this.passwrd,
  });
  get getEmail => email;

  void setEmail(email) => this.email = email;

  get getPassword => passwrd;

  void setPassword(password) => this.passwrd = password;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'passwrd': passwrd,
    };
  }

  factory LoginUser.fromMap(Map<String, dynamic> map) {
    return LoginUser(
      email: map['email'] as String,
      passwrd: map['passwrd'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginUser.fromJson(String source) =>
      LoginUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
