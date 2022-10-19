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

class LoadedLoginState extends LoginState {
  final LogInEntity logInEntity;
  final String username;

  const LoadedLoginState({required this.logInEntity, required this.username});

  @override
  List<Object> get props => [logInEntity, username];
}

class LoadingLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class ErrorLoginState extends LoginState {
  final String message;

  const ErrorLoginState({required this.message});

  @override
  List<Object> get props => [message];
}
