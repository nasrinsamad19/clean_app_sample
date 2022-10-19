import 'package:clean_app_sample/core/usecase.dart';
import 'package:clean_app_sample/features/login/domain/entities/login.dart';
import 'package:clean_app_sample/features/login/domain/repo/login_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/login_model.dart';

class LoginUseCase {
  final LoginRepo loginRepository;

  LoginUseCase({required this.loginRepository});

  Future<Either<Failure, LogInEntity>> call({
    required String username,
    required String password,
  }) async {
    return await loginRepository.loginRequests(
      password: password,
      username: username,
    );
  }
}

// class Params extends Equatable {
//   final LoginModel login;

//   const Params({
//     required this.login,
//   });

//   @override
//   List<Object> get props => [login];
// }
