part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();
}

/// Update Profile Info Event
class UpdateProfileInfoEvent extends UpdateProfileEvent {
  final Profile profile;
  final BuildContext context;
  const UpdateProfileInfoEvent({required this.profile,required this.context});
  @override
  List<Object?> get props => [profile,context];
}