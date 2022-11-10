part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}
/// Get Profile Event
 class GetProfileEvent extends ProfileEvent {
   final BuildContext context;
  const GetProfileEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
