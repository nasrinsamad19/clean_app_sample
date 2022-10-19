import 'dart:convert';
import 'dart:io';

import 'package:clean_app_sample/core/error/exception.dart';
import 'package:clean_app_sample/core/servers/server_domain.dart';
import 'package:clean_app_sample/features/sign_in/data/models/sign_in_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class SignInRemoteDataSource {
  Future<SignInModel> signIn({
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String dateOfBirth,
    required String password,
  });
}

class SignInRemoteDataSourceImpl implements SignInRemoteDataSource {
  final http.Client client;

  var en;

  SignInRemoteDataSourceImpl({required this.client});
  @override
  Future<SignInModel> signIn(
      {required String email,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String dateOfBirth,
      required String password}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final signInBody = jsonEncode({
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "dateOfBirth": dateOfBirth,
      "password": password,
    });

    final response = await client.post(Uri.parse("$userUrl/user/en/signup"),
        headers: headers, body: signInBody);
    debugPrint('data is $signInBody');
    debugPrint('${response.statusCode} | ${response.body}');
    if (response.statusCode == 201) {
      final SignInModel signInModel =
          SignInModel.fromJson(json.decode(response.body));
      return signInModel;
    } else if (response.statusCode == 400) {
      throw InvalidInputException();
    } else {
      throw ServerException();
    }
  }
}
