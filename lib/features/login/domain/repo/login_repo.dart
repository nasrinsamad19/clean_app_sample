import 'package:clean_app_sample/features/login/data/models/login_model.dart';
import 'package:clean_app_sample/features/login/domain/entities/login.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepo {
  Future<Either<Failure, bool>> login(LoginModel loginModel);
}
