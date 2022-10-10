import 'package:clean_app_sample/core/usecase.dart';
import 'package:clean_app_sample/features/login/domain/entities/login.dart';
import 'package:clean_app_sample/features/login/domain/repo/login_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/login_model.dart';

class Login implements UseCase<bool, Params> {
  final LoginRepo loginRepository;

  Login(this.loginRepository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await loginRepository.login(params.login);
  }
}

class Params extends Equatable {
  final LoginModel login;

  const Params({
    required this.login,
  });

  @override
  List<Object> get props => [login];
}
