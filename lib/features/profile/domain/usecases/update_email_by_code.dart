import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateEmailByCode {
  final ProfileRepository repository;

  UpdateEmailByCode(this.repository);

  Future<Either<Failure, Unit>> call(String code, String emailToken) async {
    return await repository.updateEmailByCode(code, emailToken);
  }
}
