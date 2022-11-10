import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

///UseCase implement method's on repositories
class UpdatePasswordUseCase {
  final ProfileRepository repository;

  ///Repository Contracture
  UpdatePasswordUseCase(this.repository);

  ///Override call Method to make class callable
  Future<Either<Failure, Unit>> call(
      String currentPassword, String newPassword) async {
    return await repository.updatePassword(currentPassword, newPassword);
  }
}
