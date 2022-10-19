import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/sign_in/domain/entities/sign_in_entities.dart';
import 'package:clean_app_sample/features/sign_in/domain/repo/sign_in_repo.dart';
import 'package:dartz/dartz.dart';

class SignInUsecase {
  final SignInRepositories signInRepositories;

  SignInUsecase({required this.signInRepositories});

  Future<Either<Failure, SignInEntity>> call(
      {required String email,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String dateOfBirth,
      required String password}) async {
    return await signInRepositories.signInRequest(
        email: email,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        password: password);
  }
}
