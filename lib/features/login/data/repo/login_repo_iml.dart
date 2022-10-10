import 'package:clean_app_sample/core/error/exception.dart';
import 'package:clean_app_sample/core/platform/network_info.dart';
import 'package:clean_app_sample/features/login/data/models/login_model.dart';
import 'package:clean_app_sample/features/login/domain/entities/login.dart';
import 'package:clean_app_sample/features/login/domain/repo/login_repo.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../datasources/login_remote_data_source.dart';

class LoginRepositoryImpl extends LoginRepo {
  final LoginUser loginUser;

  LoginRepositoryImpl(this.loginUser);
  @override
  Future<Either<Failure, bool>> loginData(LoginModel login) async {
    try {
      final user = await loginUser.login(login);
      return Right(user != null);
    } catch (exception) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> login(loginModel) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
