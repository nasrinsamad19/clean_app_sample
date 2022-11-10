import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class TimeoutFailure extends Failure {}

class SocketFailure extends Failure {}

class FormatFailure extends Failure {}

class OfflineFailure extends Failure {}

class InvalidInputFailure extends Failure {}

class InvalidCredentials extends Failure {}

class UnauthorizedFailure extends Failure {}

class ReLoginFailure extends Failure {}

class UnHandledFailure extends Failure {}

class EmptyCacheFailure extends Failure {}

class EmailAlreadyExistFailure extends Failure {}

class UsernameAlreadyExistFailure extends Failure {}

class PhoneAlreadyExistFailure extends Failure {}

class IncorrectCodeFailure extends Failure {}

class EmailTokenFailure extends Failure {}

class IncorrectPasswordFailure extends Failure {}
