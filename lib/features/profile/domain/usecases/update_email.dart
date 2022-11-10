import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

///UseCase implement method's on repositories
class UpdateEmailUseCase {
  final ProfileRepository repository;

  ///Repository Contracture
  UpdateEmailUseCase(this.repository);

  ///Override call Method to make class callable
  Future<Either<Failure, String>> call(String email) async {
    return await repository.updateEmail(email);
  }
}
