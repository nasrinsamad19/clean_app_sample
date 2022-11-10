import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/profile/domain/entities/profile.dart';
import 'package:clean_app_sample/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

///UseCase implement method's on repositories
class UpdateProfileInfoUseCase {
  final ProfileRepository repository;

  ///Repository Contracture
  UpdateProfileInfoUseCase(this.repository);

  ///Override call Method to make class callable
  Future<Either<Failure, Unit>> call(Profile profile) async {
    return await repository.updateProfileInfo(profile);
  }
}
