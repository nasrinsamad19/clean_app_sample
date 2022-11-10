part of 'update_password_bloc.dart';

abstract class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();
}

class UpdatePasswordInitial extends UpdatePasswordState {
  @override
  List<Object> get props => [];
}

class SuccessUpdatePasswordState extends UpdatePasswordState {
  final String message;

  SuccessUpdatePasswordState({required this.message});
  @override
  List<Object> get props => [message];
}

class ErrorUpdatePasswordState extends UpdatePasswordState {
  @override
  final String message;

  ErrorUpdatePasswordState({required this.message});

  List<Object?> get props => [message];
}

class LoadingUpdatePasswordState extends UpdatePasswordState {
  LoadingUpdatePasswordState();
  @override
  List<Object?> get props => [];
}
