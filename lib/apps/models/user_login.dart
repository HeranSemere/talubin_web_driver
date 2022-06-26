// To parse this JSON data, do
//
//     final userLogin = userLoginFromJson(jsonString);

import 'dart:convert';

UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
    UserLogin({
        this.message,
        this.userId,
        this.token,
    });

    String? message;
    String? userId;
    String? token;

    factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        message: json["message"],
        userId: json["userId"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "userId": userId,
        "token": token,
    };
}
