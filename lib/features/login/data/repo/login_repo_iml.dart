import 'dart:async';

import 'package:clean_app_sample/core/error/exception.dart';
import 'package:clean_app_sample/core/platform/network_info.dart';
import 'package:clean_app_sample/features/login/data/datasources/login_local_data_source.dart';
import 'package:clean_app_sample/features/login/data/models/login_model.dart';
import 'package:clean_app_sample/features/login/domain/entities/login.dart';
import 'package:clean_app_sample/features/login/domain/repo/login_repo.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../datasources/login_remote_data_source.dart';

class LoginRepositoryImpl extends LoginRepo {
  final LogInRemoteDataSources logInRemoteDataSources;
  final LoginLocalDataSources loginLocalDataSources;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl(
      {required this.logInRemoteDataSources,
      required this.loginLocalDataSources,
      required this.networkInfo});

  @override
  Future<Either<Failure, LogInEntity>> loginRequests({
    required String username,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLogin = await logInRemoteDataSources.login(
          username: username,
          password: password,
        );

        /// cache full user info
        loginLocalDataSources.cacheUserData(remoteLogin);

        // /// cache current username and password this model just have two attribute to remember user when logout
        // UserDataModel userDataModel =
        //     UserDataModel(username: username, password: password);
        // await authLocalDataSources.cacheCurrentUserData(userDataModel);

        return Right(remoteLogin);
      } on ServerException {
        return Left(ServerFailure());
      } on TimeoutException {
        return Left(TimeoutFailure());
      } on SocketFailure {
        return Left(SocketFailure());
      } on FormatException {
        return Left(FormatFailure());
      } on OfflineException {
        return Left(OfflineFailure());
      } on InvalidInputException {
        return Left(InvalidInputFailure());
      } on UserNameOrPasswordException {
        return Left(InvalidCredentials());
      } on SessionExpiredException {
        return Left(ReLoginFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
