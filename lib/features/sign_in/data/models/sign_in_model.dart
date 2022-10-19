// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

import 'package:clean_app_sample/features/sign_in/domain/entities/sign_in_entities.dart';

// ignore: must_be_immutable
class SignInModel extends SignInEntity {
  SignInModel({
    required super.message,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.password,
  });

  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  DateTime dateOfBirth;
  String password;

  factory SignInModel.fromRawJson(String str) =>
      SignInModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        message: json['message'],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "dateOfBirth": dateOfBirth,
        "password": password,
      };
}
