part of 'update_email_bloc.dart';

abstract class UpdateEmailState extends Equatable {
  const UpdateEmailState();
}

class UpdateEmailInitial extends UpdateEmailState {
  @override
  List<Object> get props => [];
}

class SuccessUpdateEmailState extends UpdateEmailState {
  final String message;
  final String emailToken;

  SuccessUpdateEmailState({required this.message, required this.emailToken});
  @override
  List<Object> get props => [message];
}

class ErrorUpdateEmailState extends UpdateEmailState {
  @override
  final String message;

  ErrorUpdateEmailState({required this.message});

  List<Object?> get props => [message];
}

class LoadingUpdateEmailState extends UpdateEmailState {
  LoadingUpdateEmailState();
  @override
  List<Object?> get props => [];
}
