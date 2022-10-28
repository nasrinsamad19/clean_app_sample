import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/users/domain/entities/users.dart';
import 'package:clean_app_sample/features/users/domain/repo/users_repo.dart';
import 'package:dartz/dartz.dart';

class GetUsersUseCase {
  final UsersRepositories usersRepositories;

  GetUsersUseCase({required this.usersRepositories});

  Future<Either<Failure, UsersEntity>> call({
    required String page,
  }) async {
    return await usersRepositories.getAllUsersRequests(page: page);
  }
}
