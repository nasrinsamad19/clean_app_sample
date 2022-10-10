import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'error/failure.dart';

abstract class UseCase<Type, Equatable> {
  Future<Either<Failure, Type>> call(Equatable params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
