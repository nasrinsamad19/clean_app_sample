// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:clean_app_sample/features/login/domain/entities/login.dart';

class UserModel extends LogInEntity {
  UserModel({
    required super.message,
    required this.email,
    required this.deviceId,
    required this.password,
    required this.fbToken,
    required this.deviceType,
    required this.deviceLang,
  });

  String email;
  String deviceId;
  String password;
  String fbToken;
  String deviceType;
  String deviceLang;

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        email: json["email"],
        deviceId: json["deviceId"],
        password: json["password"],
        fbToken: json["fbToken"],
        deviceType: json["deviceType"],
        deviceLang: json["deviceLang"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "email": email,
        "deviceId": deviceId,
        "password": password,
        "fbToken": fbToken,
        "deviceType": deviceType,
        "deviceLang": deviceLang,
      };
}
