import 'dart:io';

import 'package:clean_app_sample/core/error/failure.dart';
import 'package:clean_app_sample/features/profile/domain/entities/profile.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfileInfo();
  Future<Either<Failure, Unit>> updateProfileInfo(Profile profile);
  Future<Either<Failure, String>> updateImage(XFile image);

  Future<Either<Failure, String>> updateEmail(String email);
  Future<Either<Failure, Unit>> updateEmailByCode(
      String code, String emailToken);

  Future<Either<Failure, Unit>> updatePassword(
      String currentPassword, String newPassword);
}
