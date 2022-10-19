import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/sign_in/domain/entities/sign_in_entities.dart';
import 'package:dartz/dartz.dart';

abstract class SignInRepositories {
  Future<Either<Failure, SignInEntity>> signInRequest(
      {required String email,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String dateOfBirth,
      required String password});
}
