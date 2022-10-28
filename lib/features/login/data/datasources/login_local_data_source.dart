import 'dart:convert';
import 'package:clean_app_sample/core/error/exception.dart';
import 'package:clean_app_sample/core/servers/server_domain.dart';
import 'package:clean_app_sample/features/login/data/models/login_model.dart';
import 'package:clean_app_sample/features/sign_in/data/models/sign_in_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginLocalDataSources {
  Future<UserModel> getCachedUserData();

  Future<Unit> cacheUserData(UserModel loginModel);

  Future<Unit> clearCacheUserData();

  Future<Unit> cacheCurrentUserData(UserModel userDataModel);
}

class LoginLocalDataSourcesRepoImpl implements LoginLocalDataSources {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourcesRepoImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheUserData(UserModel loginModel) async {
    await sharedPreferences.setString(cachedUserData, json.encode(loginModel));
    return Future.value(unit);
  }

  @override
  Future<UserModel> getCachedUserData() {
    final jsonString = sharedPreferences.getString(cachedUserData);
    if (jsonString != null) {
      UserModel loginModel = UserModel.fromJson(json.decode(jsonString));
      return Future.value(loginModel);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> clearCacheUserData() async {
    await sharedPreferences.remove(cachedUserData);
    return Future.value(unit);
  }

  @override
  Future<Unit> cacheCurrentUserData(UserModel userDataModel) async {
    await sharedPreferences.setString(
        cachedCurrentUserData, json.encode(userDataModel));
    return Future.value(unit);
  }
}
