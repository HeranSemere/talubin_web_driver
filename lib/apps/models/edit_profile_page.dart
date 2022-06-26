// To parse this JSON data, do
//
//     final editProfilePage = editProfilePageFromJson(jsonString);

import 'dart:convert';

EditProfilePage editProfilePageFromJson(String str) => EditProfilePage.fromJson(json.decode(str));

String editProfilePageToJson(EditProfilePage data) => json.encode(data.toJson());

class EditProfilePage {
    EditProfilePage({
        this.message,
        this.user,
    });

    String? message;
    User? user;

    factory EditProfilePage.fromJson(Map<String, dynamic> json) => EditProfilePage(
        message: json["message"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "user": user!.toJson(),
    };
}

class User {
    User({
        this.userId,
        this.email,
        this.password,
        this.firstName,
        this.lastName,
        this.gender,
        this.dob,
        this.createdDate,
        this.updateDate,
        this.address,
        this.role,
    });

    String? userId;
    String? email;
    String? password;
    String? firstName;
    String? lastName;
    String? gender;
    DateTime? dob;
    DateTime? createdDate;
    DateTime? updateDate;
    String? address;
    String? role;

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        email: json["email"],
        password: json["password"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        createdDate: DateTime.parse(json["createdDate"]),
        updateDate: DateTime.parse(json["updateDate"]),
        address: json["address"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "createdDate": createdDate!.toIso8601String(),
        "updateDate": updateDate!.toIso8601String(),
        "address": address,
        "role": role,
    };
}
