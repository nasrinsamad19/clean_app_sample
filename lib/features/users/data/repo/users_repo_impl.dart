import 'package:clean_app_sample/core/error/exception.dart';
import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/core/platform/network_info.dart';
import 'package:clean_app_sample/features/login/data/datasources/login_local_data_source.dart';
import 'package:clean_app_sample/features/login/data/datasources/login_remote_data_source.dart';
import 'package:clean_app_sample/features/login/data/models/login_model.dart';
import 'package:clean_app_sample/features/users/data/datasource/users_remote_datasources.dart';
import 'package:clean_app_sample/features/users/domain/entities/users.dart';
import 'package:clean_app_sample/features/users/domain/repo/users_repo.dart';
import 'package:dartz/dartz.dart';

class UsersRepoImpl implements UsersRepositories {
  final UsersRemoteDataSources usersRemoteDataSources;

  final LoginLocalDataSources loginLocalDataSources;
  final LogInRemoteDataSources logInRemoteDataSources;
  final NetworkInfo networkInfo;

  UsersRepoImpl(
      {required this.networkInfo,
      required this.usersRemoteDataSources,
      required this.loginLocalDataSources,
      required this.logInRemoteDataSources});

  @override
  Future<Either<Failure, UsersEntity>> getAllUsersRequests(
      {required String page}) async {
    try {
      var cached = await loginLocalDataSources.getCachedUserData();
      var users = await usersRemoteDataSources.getUsers(
          page: page, token: cached.token);
      return Right(users);
    } on UnAuthorizedException {
      var cached = await loginLocalDataSources.getCachedUserData();
      var result = await logInRemoteDataSources.refreshAccess(
          refreshToken: cached.refreshtoken);
      UserModel userLoginModel = UserModel(
          message: cached.message,
          username: cached.username,
          phone: cached.phone,
          email: cached.email,
          image: cached.image,
          userTypeInfo: cached.userTypeInfo,
          companyInfo: cached.companyInfo,
          token: result.token,
          refreshtoken: result.refreshtoken);
      loginLocalDataSources.cacheUserData(userLoginModel);
      return getAllUsersRequests(page: page);
    } catch (e) {
      return Left(UnHandledFailure());
    }
  }
}
