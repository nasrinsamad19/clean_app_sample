part of 'update_email_by_code_bloc.dart';

abstract class UpdateEmailByCodeState extends Equatable {
  const UpdateEmailByCodeState();
}

class UpdateEmailByCodeInitial extends UpdateEmailByCodeState {
  @override
  List<Object> get props => [];
}

class SuccessUpdateEmailByCodeState extends UpdateEmailByCodeState {
  final String message;

  SuccessUpdateEmailByCodeState({required this.message});
  @override
  List<Object> get props => [message];
}

class ErrorUpdateEmailByCodeState extends UpdateEmailByCodeState {
  @override
  final String message;

  ErrorUpdateEmailByCodeState({required this.message});

  List<Object?> get props => [message];
}

class LoadingUpdateEmailByCodeState extends UpdateEmailByCodeState {
  LoadingUpdateEmailByCodeState();
  @override
  List<Object?> get props => [];
}
