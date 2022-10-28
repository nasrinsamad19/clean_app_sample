import 'dart:convert';

import 'package:clean_app_sample/core/error/exception.dart';
import 'package:clean_app_sample/core/servers/server_domain.dart';
import 'package:clean_app_sample/features/users/data/model/users_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class UsersRemoteDataSources {
  Future<Users> getUsers({
    required String page,
    required String token,
  });
}

class UsersRemoteDataSourcesImpl implements UsersRemoteDataSources {
  final http.Client client;

  UsersRemoteDataSourcesImpl({required this.client});

  @override
  Future<Users> getUsers({
    required String page,
    required String token,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await client.get(
      Uri.parse("$userUrl/user/getUser?page=$page&limit=10"),
      headers: headers,
    );
    debugPrint('GET | $userUrl/user/getUser?page=$page&limit=10');

    debugPrint('${response.statusCode} | ${response.body}');
    if (response.statusCode == 200) {
      final Users usersModel = Users.fromJson(json.decode(response.body));
      print(usersModel.userData.limit);
      return usersModel;
    } else if (response.statusCode == 453) {
      throw UserNameOrPasswordException();
    } else if (response.statusCode == 401) {
      throw UnAuthorizedException();
    } else if (response.statusCode == 400) {
      throw InvalidInputException();
    } else {
      throw ServerException();
    }
  }
}
