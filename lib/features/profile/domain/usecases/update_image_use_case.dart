import 'dart:io';

import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

///UseCase implement method's on repositories
class UpdateProfileImageUseCase {
  final ProfileRepository repository;

  ///Repository Contracture
  UpdateProfileImageUseCase(this.repository);

  ///Override call Method to make class callable
  Future<Either<Failure, String>> call(XFile image) async {
    return await repository.updateImage(image);
  }
}
