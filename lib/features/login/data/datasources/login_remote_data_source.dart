import 'dart:async';
import 'dart:convert';
import 'package:clean_app_sample/core/error/exception.dart';
import 'package:clean_app_sample/core/servers/server_domain.dart';
import 'package:clean_app_sample/features/login/data/models/login_model.dart';
import 'package:clean_app_sample/features/login/data/models/refresh_model.dart';
import 'package:clean_app_sample/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class LogInRemoteDataSources {
  Future<UserModel> login({required String username, required String password});

  Future<RefreshModel> refreshAccess({
    required String refreshToken,
  });
}

class LogInRemoteDataSourcesImpl implements LogInRemoteDataSources {
  final http.Client client;

  LogInRemoteDataSourcesImpl({required this.client});

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "username": username,
      "password": password,
      "platform": platform,
      "uuid": "76287c76w687cw87"
    });

    final response = await client.post(Uri.parse("$userUrl/user/auth/login"),
        headers: headers, body: body);
    debugPrint('data is $body');
    debugPrint('${response.statusCode} | ${response.body}');
    if (response.statusCode == 200) {
      final UserModel loginModel =
          UserModel.fromJson(json.decode(response.body));
      return loginModel;
    } else if (response.statusCode == 453) {
      throw UserNameOrPasswordException();
    } else if (response.statusCode == 400) {
      throw InvalidInputException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RefreshModel> refreshAccess({required String refreshToken}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final mBody = jsonEncode({"refreshToken": refreshToken});
    final response = await client.post(
        Uri.parse("$userUrl/api/user/auth/refresh-token"),
        headers: headers,
        body: mBody);
    debugPrint('POST | $userUrl/api/user/auth/refresh-token');

    debugPrint('${response.statusCode} | ${response.body}');
    if (response.statusCode == 200) {
      final RefreshModel refreshModel =
          RefreshModel.fromJson(json.decode(response.body));
      return refreshModel;
    } else if (response.statusCode == 456) {
      throw SessionExpiredException();
    } else {
      throw ServerException();
    }
  }
}
