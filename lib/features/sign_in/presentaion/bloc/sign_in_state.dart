part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class LoadingSignState extends SignInState {}

class ErrorSignState extends SignInState {
  final String message;

  const ErrorSignState({required this.message});

  @override
  List<Object> get props => [message];
}

class LoadedSignState extends SignInState {
  final SignInEntity signInEntity;
  final String name;

  const LoadedSignState({required this.signInEntity, required this.name});

  @override
  List<Object> get props => [signInEntity, name];
}

class CheckingSignState extends SignInState {
  @override
  List<Object> get props => [];
}
