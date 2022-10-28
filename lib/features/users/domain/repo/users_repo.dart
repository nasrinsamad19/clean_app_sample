import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/users/domain/entities/users.dart';
import 'package:dartz/dartz.dart';

abstract class UsersRepositories {
  Future<Either<Failure, UsersEntity>> getAllUsersRequests({
    required String page,
  });
}
