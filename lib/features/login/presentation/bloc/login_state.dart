part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class CheckingLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoggedState extends LoginState {
  @override
  List<Object> get props => [];
}

class ErrorLoggedState extends LoginState {
  @override
  List<Object> get props => [];
}
