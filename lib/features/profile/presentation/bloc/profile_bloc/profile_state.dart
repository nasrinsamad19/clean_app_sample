part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}
///Success Get Profile
class SuccessGetProfileState extends ProfileState {
  final Profile profile;

  const SuccessGetProfileState({required this.profile});
  @override
  List<Object> get props => [profile];
}
///Error Get Profile
class ErrorGetProfileState extends ProfileState {
  final String message;

  const ErrorGetProfileState({required this.message});
  @override
  List<Object> get props => [message];
}
///Loading Get Profile
class LoadingGetProfileState extends ProfileState {
  const LoadingGetProfileState();
  @override
  List<Object> get props => [];
}
