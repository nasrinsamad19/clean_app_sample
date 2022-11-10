import 'dart:io';

import 'package:clean_app_sample/core/error/exception.dart';
import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/core/platform/network_info.dart';
import 'package:clean_app_sample/features/login/data/datasources/login_local_data_source.dart';
import 'package:clean_app_sample/features/login/data/datasources/login_remote_data_source.dart';
import 'package:clean_app_sample/features/login/data/models/login_model.dart';
import 'package:clean_app_sample/features/profile/data/datasources/profile_remote_datasources.dart';
import 'package:clean_app_sample/features/profile/domain/entities/profile.dart';
import 'package:clean_app_sample/features/profile/domain/repositories/profile_repository.dart';
import 'package:clean_app_sample/features/profile/domain/usecases/update_email_by_code.dart';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

class ProfileRepositoryImp extends ProfileRepository {
  final LoginLocalDataSources loginLocalDataSources;
  final LogInRemoteDataSources logInRemoteDataSources;
  final NetworkInfo networkInfo;
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImp(this.loginLocalDataSources, this.logInRemoteDataSources,
      this.networkInfo, this.profileRemoteDataSource);
  @override
  Future<Either<Failure, Profile>> getProfileInfo() async {
    if (await networkInfo.isConnected) {
      try {
        var cached = await loginLocalDataSources.getCachedUserData();
        String token = cached.token;
        final remoteProfile =
            await profileRemoteDataSource.getProfileInfo(token);
        return right(remoteProfile);
      } on ServerException {
        return left(ServerFailure());
      } on UnAuthorizedException {
        try {
          var cached = await loginLocalDataSources.getCachedUserData();
          final remoteLogin = await logInRemoteDataSources.refreshAccess(
              refreshToken: cached.refreshtoken);
          cached = UserModel(
              message: remoteLogin.message,
              username: cached.username,
              companyInfo: cached.companyInfo,
              refreshtoken: remoteLogin.refreshtoken,
              phone: cached.phone,
              token: remoteLogin.token,
              email: cached.email,
              userTypeInfo: cached.userTypeInfo,
              image: cached.image);
          loginLocalDataSources.cacheUserData(cached);
          return await getProfileInfo();
        } on ServerException {
          await loginLocalDataSources.clearCacheUserData();
          return Left(ReLoginFailure());
        }
      } on SessionExpiredException {
        await loginLocalDataSources.clearCacheUserData();
        return Left(ReLoginFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProfileInfo(Profile profile) async {
    if (await networkInfo.isConnected) {
      try {
        var cached = await loginLocalDataSources.getCachedUserData();
        String token = cached.token;
        final remoteProfile =
            await profileRemoteDataSource.updateProfileInfo(token, profile);
        return right(remoteProfile);
      } on ServerException {
        return left(ServerFailure());
      } on EmailAlreadyExistException {
        return left(EmailAlreadyExistFailure());
      } on PhoneAlreadyExistException {
        return left(PhoneAlreadyExistFailure());
      } on UsernameAlreadyExistException {
        return left(UsernameAlreadyExistFailure());
      } on UnAuthorizedException {
        try {
          var cached = await loginLocalDataSources.getCachedUserData();
          final remoteLogin = await logInRemoteDataSources.refreshAccess(
              refreshToken: cached.refreshtoken);
          cached = UserModel(
              message: remoteLogin.message,
              username: cached.username,
              companyInfo: cached.companyInfo,
              refreshtoken: remoteLogin.refreshtoken,
              phone: cached.phone,
              token: remoteLogin.token,
              email: cached.email,
              userTypeInfo: cached.userTypeInfo,
              image: cached.image);
          loginLocalDataSources.cacheUserData(cached);
          return await updateProfileInfo(profile);
        } on ServerException {
          await loginLocalDataSources.clearCacheUserData();
          return Left(ReLoginFailure());
        }
      } on SessionExpiredException {
        await loginLocalDataSources.clearCacheUserData();
        return Left(ReLoginFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updateEmailStepOne(String email) {
    // TODO: implement updateEmailStepOne
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateEmailStepStepTwo(
      String emailToken, String code) {
    // TODO: implement updateEmailStepStepTwo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> updateEmail(String email) async {
    if (await networkInfo.isConnected) {
      try {
        var cached = await loginLocalDataSources.getCachedUserData();
        String token = cached.token;
        final remoteProfile =
            await profileRemoteDataSource.updateEmail(token, email);
        return right(remoteProfile);
      } on ServerException {
        return left(ServerFailure());
      } on EmailAlreadyExistException {
        return left(EmailAlreadyExistFailure());
      } on UnAuthorizedException {
        try {
          var cached = await loginLocalDataSources.getCachedUserData();
          final remoteLogin = await logInRemoteDataSources.refreshAccess(
              refreshToken: cached.refreshtoken);
          cached = UserModel(
              message: remoteLogin.message,
              username: cached.username,
              companyInfo: cached.companyInfo,
              refreshtoken: remoteLogin.refreshtoken,
              phone: cached.phone,
              token: remoteLogin.token,
              email: cached.email,
              userTypeInfo: cached.userTypeInfo,
              image: cached.image);
          loginLocalDataSources.cacheUserData(cached);
          return await updateEmailStepOne(email);
        } on ServerException {
          await loginLocalDataSources.clearCacheUserData();
          return Left(ReLoginFailure());
        }
      } on SessionExpiredException {
        await loginLocalDataSources.clearCacheUserData();
        return Left(ReLoginFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateEmailByCode(
      String code, String emailToken) async {
    if (await networkInfo.isConnected) {
      try {
        var cached = await loginLocalDataSources.getCachedUserData();
        String token = cached.token;
        final remoteProfile = await profileRemoteDataSource.updateEmailByCode(
            token, emailToken, code);
        return right(remoteProfile);
      } on ServerException {
        return left(ServerFailure());
      } on IncorrectCodeException {
        return left(IncorrectCodeFailure());
      } on EmailTokenException {
        return left(EmailTokenFailure());
      } on UnAuthorizedException {
        try {
          var cached = await loginLocalDataSources.getCachedUserData();
          final remoteLogin = await logInRemoteDataSources.refreshAccess(
              refreshToken: cached.refreshtoken);
          cached = UserModel(
              message: remoteLogin.message,
              username: cached.username,
              companyInfo: cached.companyInfo,
              refreshtoken: remoteLogin.refreshtoken,
              phone: cached.phone,
              token: remoteLogin.token,
              email: cached.email,
              userTypeInfo: cached.userTypeInfo,
              image: cached.image);
          loginLocalDataSources.cacheUserData(cached);
          return await updateEmailStepStepTwo(emailToken, code);
        } on ServerException {
          await loginLocalDataSources.clearCacheUserData();
          return Left(ReLoginFailure());
        }
      } on SessionExpiredException {
        await loginLocalDataSources.clearCacheUserData();
        return Left(ReLoginFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updateImage(XFile image) async {
    if (await networkInfo.isConnected) {
      try {
        var cached = await loginLocalDataSources.getCachedUserData();
        String token = cached.token;
        final remoteProfile =
            await profileRemoteDataSource.updateImage(token, image);
        return right(remoteProfile);
      } on ServerException {
        return left(ServerFailure());
      } on UnAuthorizedException {
        try {
          var cached = await loginLocalDataSources.getCachedUserData();
          final remoteLogin = await logInRemoteDataSources.refreshAccess(
              refreshToken: cached.refreshtoken);
          cached = UserModel(
              message: remoteLogin.message,
              username: cached.username,
              companyInfo: cached.companyInfo,
              refreshtoken: remoteLogin.refreshtoken,
              phone: cached.phone,
              token: remoteLogin.token,
              email: cached.email,
              userTypeInfo: cached.userTypeInfo,
              image: cached.image);
          loginLocalDataSources.cacheUserData(cached);
          return await updateImage(image);
        } on ServerException {
          await loginLocalDataSources.clearCacheUserData();
          return Left(ReLoginFailure());
        }
      } on SessionExpiredException {
        await loginLocalDataSources.clearCacheUserData();
        return Left(ReLoginFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePassword(
      String currentPassword, String newPassword) async {
    if (await networkInfo.isConnected) {
      try {
        var cached = await loginLocalDataSources.getCachedUserData();
        String token = cached.token;
        final remoteProfile = await profileRemoteDataSource.updatePassword(
            token, currentPassword, newPassword);
        return right(remoteProfile);
      } on ServerException {
        return left(ServerFailure());
      } on IncorrectPasswordException {
        return left(IncorrectPasswordFailure());
      } on UnAuthorizedException {
        try {
          var cached = await loginLocalDataSources.getCachedUserData();
          final remoteLogin = await logInRemoteDataSources.refreshAccess(
              refreshToken: cached.refreshtoken);
          cached = UserModel(
              message: remoteLogin.message,
              username: cached.username,
              companyInfo: cached.companyInfo,
              refreshtoken: remoteLogin.refreshtoken,
              phone: cached.phone,
              token: remoteLogin.token,
              email: cached.email,
              userTypeInfo: cached.userTypeInfo,
              image: cached.image);
          loginLocalDataSources.cacheUserData(cached);
          return await updatePassword(currentPassword, newPassword);
        } on ServerException {
          await loginLocalDataSources.clearCacheUserData();
          return Left(ReLoginFailure());
        }
      } on SessionExpiredException {
        await loginLocalDataSources.clearCacheUserData();
        return Left(ReLoginFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
