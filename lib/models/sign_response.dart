import 'dart:convert';

class SignResponse {
  bool isSuccess;
  int code;
  String message;
  SignResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
  });

  get getStatus => isSuccess;

  void setStatus(isSuccess) => this.isSuccess = isSuccess;

  get getCode => code;

  void setCode(code) => this.code = code;

  get getMsg => message;

  void setMsg(message) => this.message = message;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isSuccess': isSuccess,
      'code': code,
      'message': message,
    };
  }

  factory SignResponse.fromMap(Map<String, dynamic> map) {
    return SignResponse(
      isSuccess: map['isSuccess'] as bool,
      code: map['code'] as int,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignResponse.fromJson(String source) =>
      SignResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
