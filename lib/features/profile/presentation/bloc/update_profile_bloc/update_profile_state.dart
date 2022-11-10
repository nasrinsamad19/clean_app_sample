part of 'update_profile_bloc.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();
}

class UpdateProfileInitial extends UpdateProfileState {
  @override
  List<Object> get props => [];
}

class SuccessUpdateProfileInfoState extends UpdateProfileState {
  final String message;

  const SuccessUpdateProfileInfoState({required this.message});
  @override
  List<Object> get props => [message];
}

class ErrorUpdateProfileInfoState extends UpdateProfileState {
  final String message;

  const ErrorUpdateProfileInfoState({required this.message});
  @override
  List<Object> get props => [message];
}

class LoadingUpdateProfileInfoState extends UpdateProfileState {
  const LoadingUpdateProfileInfoState();
  @override
  List<Object> get props => [];
}
