// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:clean_app_sample/features/login/domain/entities/login.dart';

class UserModel extends LogInEntity {
  UserModel({
    required super.message,
    required this.username,
    required this.phone,
    required this.email,
    required this.image,
    required this.userTypeInfo,
    required this.companyInfo,
    required this.token,
    required this.refreshtoken,
  });

  String username;
  String phone;
  String email;
  String image;
  UserTypeInfo userTypeInfo;
  CompanyInfo companyInfo;
  String token;
  String refreshtoken;

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        username: json["username"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
        userTypeInfo: UserTypeInfo.fromJson(json["userTypeInfo"]),
        companyInfo: CompanyInfo.fromJson(json["companyInfo"]),
        token: json["token"],
        refreshtoken: json["refreshtoken"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "username": username,
        "phone": phone,
        "email": email,
        "image": image,
        "userTypeInfo": userTypeInfo.toJson(),
        "companyInfo": companyInfo.toJson(),
        "token": token,
        "refreshtoken": refreshtoken,
      };
}

class CompanyInfo {
  CompanyInfo({
    required this.companyId,
    required this.companyName,
  });

  int companyId;
  String companyName;

  factory CompanyInfo.fromRawJson(String str) =>
      CompanyInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyInfo.fromJson(Map<String, dynamic> json) => CompanyInfo(
        companyId: json["companyId"],
        companyName: json["companyName"],
      );

  Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "companyName": companyName,
      };
}

class UserTypeInfo {
  UserTypeInfo({
    required this.userType,
    required this.userTypeId,
  });

  String userType;
  int userTypeId;

  factory UserTypeInfo.fromRawJson(String str) =>
      UserTypeInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserTypeInfo.fromJson(Map<String, dynamic> json) => UserTypeInfo(
        userType: json["userType"],
        userTypeId: json["userTypeId"],
      );

  Map<String, dynamic> toJson() => {
        "userType": userType,
        "userTypeId": userTypeId,
      };
}
